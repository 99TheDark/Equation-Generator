using LinearAlgebra

r(size::Int64) = convert(Float64, rand(-size:size))
letters = split("abcdefghijklmnopqrstuvwxyz", "")

function generate(dims::Int64, size::Int64 = 8) # dims within 1 to 26
	range = [collect(-size:-1); collect(1:size)]

	coefficients = rand(range, dims, dims)
	variables = rand(range, dims)
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
			str *= string(k) * string(letters[length(letters)-dims+i])
		end

		str *= "=" * string(answers[j]) * "\n"
	end

	return str
end

println(generate(3))
