"""
    Polygon(x, y)

Construct a Polygon object.
"""
struct Polygon{T}
    x::Vector{T}
    y::Vector{T}
end

next_index(index, n) = index == n ? 1 : index + 1
prev_index(index, n) = index == 1 ? n : index - 1s

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
    for index in 1:n
        next = next_index(index, n)
        sum += x[index] * y[next] - x[next] * y[index]
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
    for index in 1:n
        next = next_index(index, n)
        x1, x2 = x[index], x[next]
        y1, y2 = y[index], y[next]
        tmp = (x1 * y2 - x2 * y1)
        Cx += (x1 + x2) * tmp
        Cy += (y1 + y2) * tmp
    end
    A = area(p)
    Cx /= (6A)
    Cy /= (6A)
    return Cx, Cy
end

"""
    moment_of_area(p::Polygon)

Calculates second moment of area of p for rotation about perpendicular axis.

# Examples
```jldoctest
julia> rect = Rectangle(3, 3)
Polygon{Float64}([1.0, 1.0, -1.0, -1.0], [-0.5, 0.5, 0.5, -0.5])
julia> moment_of_area(rect)
13.5
```
"""
function moment_of_area(p::Polygon)
    x, y = p.x, p.y
    n = Base.length(x)
    sum = 0.0
    for index in 1:n
        next = next_index(index, n)
        x1, x2 = x[index], x[next]
        y1, y2 = y[index], y[next]
        tmp1 = x1 * y2 - x2 * y1
        tmp2 = x1^2 + x1 * x2 + x2^2
        tmp3 = y1^2 + y1 * y2 + y2^2
        sum += tmp1 * (tmp2 + tmp3)  
    end
    return sum / 12
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


"""
    submerged(p::Polygon, h=0)

Returns a Polygon of the portion of p that is below the plane y=h.
"""
function submerged(p::Polygon, h=0)
    x = Vector{Float64}()
    y = Vector{Float64}()
    n = Base.length(p.x)
    for index in 1:n
        if p.y[index] <= h
            append!(x, p.x[index])
            append!(y, p.y[index])
        else
            prev = index == 1 ? n : index - 1
            if p.y[prev] <= h
                xI = intersect_with_horizontal(
                    p.x[prev],
                    p.y[prev],
                    p.x[index],
                    p.y[index],
                    h
                )
                append!(x, xI)
                append!(y, h)
            end
            next = index == n ? 1 : index + 1
            if p.y[next] <= h
                xI = intersect_with_horizontal(
                    p.x[index],
                    p.y[index],
                    p.x[next],
                    p.y[next],
                    h
                )
                append!(x, xI)
                append!(y, h)
            end
        end
    end
    return Polygon(x, y)
end

function intersect_with_horizontal(x1, y1, x2, y2, h)
    return (x2 * (h - y1) - x1 * (h - y2)) / (y2 - y1)
end
