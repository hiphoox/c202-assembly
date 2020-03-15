defmodule Parser do

	def parse(OTL, GAST) do
		PS_M = generatePossibleStructureMap(GAST)
		root_AST = generateRootAST()
		{result_token, OAST, TL, error_cause} = myStructureMatches(root_AST, OTL, nil, PS_M)
		if TL === [] do
			{result_token,OAST,TL,error_cause}
		else
			{:token_not_absorbed_error,OAST,TL,error_cause}
		end
	end

	defp myStructureMatches(CS,TL,p_s,PS_M) do
		{result_token_1, TL_1, absorbed_token} = myTokenMatches(CS,TL)
		if result_token_1 === :ok do
			{result_token_2, TL_2, children_list,error_cause} = myChildrenMatch(CS,TL_1,PS_M)
			if result_token_2 === :ok do
				D_CS = specifizeStructure(CS,absorbed_token,children_list,p_s)
				{:ok,D_CS,TL_2,nil}
			else
				{:error,CS,TL,error_cause} #:structure-does-not-match-expectation
			end
		else
			{:error,CS,TL,:dontmatter} #:Could not absorb token of structure
		end
	end
	
	defp myChildrenMatch(CS,TL,PS_M) do
		ChildrenList = CS.children
		nextChildMatch(ChildrenList,TL,[],CS,PS_M)
	end
	
	defp nextChildMatch([],TL,previous_children,p_s,PS_M) do
		{:ok, TL, previous_children, nil}
	end
	defp nextChildMatch(CL,TL,previousChildren,p_s,PS_M) do
		[child | CL_1] = CL
		Possible_Structures = PS_M[child.class]
		{result_token, Matched_Structure, TL_1, incoming_error} = checkPS(Possible_Structures,TL,p_s,PS_M)
		if result_token === :ok do
			nextChildMatch(CL_1,TL_1,previousChildren++[Matched_Structure],p_s,PS_M)
		else
			child_e = setProblemChildParent(child,p_s)
			if incoming_error === nil do
				{:error,TL,previousChildren++[child_e],child_e}
			else
				{:error,TL,previousChildren++[child_e],incoming_error}
			end
		end
	end		
	
	defp checkPS([],TL,p_s,PS_M) do
		{:error,nil,TL,nil}
	end
	defp checkPS(PS,TL,p_s,PS_M) do
		[Candidate_Structure | PS_1] = PS
		{result_token,current_candidate,TL_1,error_cause} = myStructureMatches(Candidate_Structure,TL,p_s,PS_M)
		if result_token === :ok do 
			{:ok,current_candidate,TL_1,nil}
		else
			checkPS(PS_1,TL,p_s,PS_M)
		end

	end
	defp myTokenMatches(CS,TL) do
		[absorbed_token | TL_1] = TL
		if CS.token === nil do
			{:ok,TL,nil}
		else
			if CS.token === absorbed_token.tag do
				{:ok,TL_1,absorbed_token}
			else
				{:error,TL,absorbed_token}
			end
			
		end
	end
	defp specifizeStructure(CS,absorbed_token,children_list,parent_s) do
		%{node |class: CS.class, 
			token: absorbed_token, 
			tag: CS.tag, 
			asm: CS.asm, 
			children: Enum.map(children_list, fn c -> elem(c, 1) end),
			parent: parent_s
		}
	end
	
	defp setProblemChildParent(child,parent_s) do
		%{node |class: child.class, 
			token: nil, 
			tag: child.tag, 
			asm: child.asm, 
			children: nil,
			parent: parent_s
		}
	end
	defp generatePossibleStructureMap(GAST) do
		keys = (Enum.map(GAST, fn x -> [x.class] end) |> List.flatten |> Enum.uniq)
		Enum.map(keys, fn k -> {k,Enum.filter(GAST, fn y -> Enum.member?(List.flatten([y.class]),k) end)} end)
		|> Map.new
	end
	defp generateRootAST() do
		%{node |class: :root,
			token: nil,
			tag: :root,
			children: [%{"class"=>"program-root", "tag"=>"program-root"}],
			asm: "mov :r, :0",
			parent: nil
		}
	end
end
