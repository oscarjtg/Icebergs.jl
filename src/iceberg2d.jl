mutable struct Iceberg2D
    shape::Polygon
    x::Real
    y::Real
    theta::Real
    vertices::Polygon
    density::Real
    length::Real
end

"""
    update_vertices(berg::Iceberg2D)

Updates the coordinates of the vertices based on x, y, theta.

The `shape` attribute is assumed to give the positions 
of the iceberg vertices when x = 0, y = 0, and theta = 0.
"""
function update_vertices!(berg::Iceberg2D)
    cos_ = cos(berg.theta)
    sin_ = sin(berg.theta)
    n = berg.shape.x
    for i in 1:n
        berg.vertices.x[i] = berg.x + berg.shape.x[i] * cos_ - berg.shape.y[i] * sin_
        berg.vertices.y[i] = berg.y + berg.shape.x[i] * sin_ + berg.shape.y[i] * cos_
    end
end
