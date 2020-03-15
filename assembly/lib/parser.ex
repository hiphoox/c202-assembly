defmodule Parser do

	def parse(OTL, GAST) do
		PS_M = GeneratePossibleStructureMap(GAST)
		root_AST = GenerateRootAST()
		{result_token, OAST, TL, error_cause} = MyStructureMatches?(root_AST, OTL, nil, PS_M)
		if TL === [] do
			{result_token,OAST,TL,error_cause}
		else
			{:token_not_absorbed_error,OAST,TL,error_cause}
		end
	end

	defp MyStructureMatches?(CS,TL,p_s,PS_M) do
		{result_token_1, TL_1, absorbed_token} = MyTokenMatches?(CS,TL)
		if result_token_1 === :ok do
			{result_token_2, TL_2, children_list,error_cause} = MyChildrenMatch?(CS,TL_1,PS_M)
			if result_token_2 === :ok do
				D_CS = SpecifizeStructure(CS,absorbed_token,children_list,p_s)
				{:ok,D_CS,TL_2,nil}
			else
				{:error,CS,TL,error_cause} #:structure-does-not-match-expectation
			end
		else
			{:error,CS,TL,:dontmatter} #:Could not absorb token of structure
		end
	end
	
	defp MyChildrenMatch?(CS,TL,PS_M) do
		ChildrenList = CS.children
		NextChildMatch?(ChildrenList,TL,[],CS,PS_M)
	end
	
	defp NextChildMatch?([],TL,previousChildren,p_s,cascading_error,PS_M) do
		{:ok, TL, previous_children, cascading_error}
	end
	defp NextChildMatch?(CL,TL,previousChildren,p_s,cascading_error,PS_M) do
		[child | CL_1] = CL
		Possible_Structures = PS_M[child.class]
		{result_token, Matched_Structure, TL_1} = CheckPS?(Possible_Structures,TL,p_s,nil,PS_M)
		if result_token === :ok do
			NextChildMatch?(CL_1,TL_1,previousChildren++[Matched_Structure],p_s,PS_M)
		else
			child_e = SetProblemChildParent(child,p_s)
			if cascading_error === nil do
				{:error,TL,previousChildren++[child_e],child_e}
			else
				{:error,TL,previousChildren++[child_e],cascading_error}
		end
	end		
	
	defp CheckPS?([],TL,p_s,cascading_error,PS_M) do
		{:error,nil,TL,cascading_error}
	end
	defp CheckPS?(PS,TL,p_s,cascading_error,PS_M) do
		[Candidate_Structure | PS_1] = PS
		{result_token,current_candidate,TL_1,error_cause} = MyStructureMatches?(Candidate_Structure,TL,p_s,cascading_error,PS_M)
		if result_token === :ok do 
			{:ok,current_candidate,TL_1,cascading_error}
		else
			CheckPS?(PS_1,TL,error_cause,PS_M)
		end

	end
	defp MyTokenMatches(CS,TL) do
		[absorbed_token | TL_1] = TL
		if CS.token === absorbed_token.tag do
			{:ok,TL_1,absorbed_token}
		else
			if CS.token === nil do
				{:ok,TL,nil}
			else
				{:error,TL_1,absorbed_token}
			end
			
		end
	end
	defp SpecifizeStructure(CS,absorbed_token,children_list,parent_s) do
		%{node |class: CS.class, 
			token: absorbed_token, 
			tag: CS.tag, 
			asm : CS.asm, 
			children: Enum.map(children_list, fn c -> elem(c, 1) end),
			parent: parent_s
		}
	end
	
	defp SetProblemChildParent(child,parent_s) do
		%{node |class: child.class, 
			token: nil, 
			tag: child.tag, 
			asm : child.asm, 
			children: nil,
			parent: parent_s
		}
	end
	defp GeneratePossibleStructureMap(GAST) do
		keys = (Enum.map(GAST, fn x -> [x.class] end) |> List.flatten |> Enum.uniq)
		Enum.map(keys, fn k -> {k,Enum.filter(GAST, fn y -> Enum.member?(List.flatten([y.class]),k) end)} end)
		|> Map.new
	end
	defp GenerateRootAST() do
		%{node |class: :root,
			token: nil,
			tag: :root,
			children: [%{"class"=>"program-root", "tag"=>"program-root"}],
			asm : "mov :r, :0",
			parent: nil
		}
	end
end
