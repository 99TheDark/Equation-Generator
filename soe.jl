using LinearAlgebra

module SystemOfEquations

export generate_soe

letters = split("abcdefghijklmnopqrstuvwxyz", "")

function generate_soe(dims::Int64, size::Int64 = 8) # dims within 1 to 26
	function strvar(idx::Int64)::String
		k = length(letters) - dims + idx
		if dims <= 2
			k -= 3 - dims
		end

		return string(letters[k])
	end

	coefficients = rand([collect(-size:-1); collect(1:size)], dims, dims)
	variables = rand(-size:size, dims)
	answers::Vector{Int64} = []

	for row in eachrow(coefficients)
		sum = 0
		for i in 1:dims
			sum += row[i] * variables[i]
		end

		push!(answers, sum)
	end

	str = ""
	for j in 1:dims
		for i in 1:dims
			k = coefficients[j, i]

			if k >= 0 && i != 1
				str *= "+"
			end
			if k == -1
				str *= "-"
			elseif k != 1
				str *= string(k)
			end

			str *= strvar(i)
		end

		str *= "=" * string(answers[j]) * "\n"
	end

	str *= "\n"

	for i in 1:dims
		str *= strvar(i) * "=" * string(variables[i]) * "\n"
	end

	return str
end

end