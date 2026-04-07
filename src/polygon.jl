"""
    Polygon(x, y)

Construct a Polygon object.
"""
struct Polygon{T}
    x::Vector{T}
    y::Vector{T}
end

"""
    area(p::Polygon)

Compute the area of the polygon using Gauss' formula.

# Examples
```jldoctest
julia> rect = Rectangle(2, 1)
Polygon{Float64}([1.0, 1.0, -1.0, -1.0], [-0.5, 0.5, 0.5, -0.5])
julia> area(rect)
2.0
```
"""
function area(p::Polygon)
    x, y = p.x, p.y
    n = Base.length(x)
    sum = 0.0
    for i in 1:n
        j = (i % n) + 1
        sum += x[i] * y[j] - x[j] * y[i]
    end
    A = 0.5 * sum
    return A
end

"""
    centroid(p::Polygon)

Compute the coordinates of the centroid of the polygon.

# Examples
```jldoctest
julia> rect = Rectangle(2, 1)
Polygon{Float64}([1.0, 1.0, -1.0, -1.0], [-0.5, 0.5, 0.5, -0.5])
julia> centroid(rect)
(0.0, 0.0)
```
"""
function centroid(p::Polygon)
    x, y = p.x, p.y
    n = Base.length(x)
    Cx, Cy = 0.0, 0.0
    for i in 1:n
        j = (i % n) + 1
        Cx += (x[i] + x[j]) * (x[i] * y[j] - x[j] * y[i])
        Cy += (y[i] + y[j]) * (x[i] * y[j] - x[j] * y[i])
    end
    A = area(p)
    Cx /= (6A)
    Cy /= (6A)
    return Cx, Cy
end

"""
    Rectangle(width, height)

Construct a rectangle centred at the origin.

# Examples
```jldoctest
julia> rect = Rectangle(2, 1)
Polygon{Float64}([1.0, 1.0, -1.0, -1.0], [-0.5, 0.5, 0.5, -0.5])
```
"""
Rectangle(width, height) = Polygon(
    [width/2, width/2, -width/2, -width/2], 
    [-height/2, height/2, height/2, -height/2]
    )