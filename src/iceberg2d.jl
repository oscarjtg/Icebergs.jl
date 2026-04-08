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
    Iceberg2D(shape::Polygon, length, density=920.0)

Construct an Iceberg2D object.
"""
function Iceberg2D(shape::Polygon, length, density=920.0)
    vertices = deepcopy(shape)
    Iceberg2D(shape, 0.0, 0.0, 0.0, vertices, density, length)
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
    n = Base.length(berg.shape.x)
    for i in 1:n
        berg.vertices.x[i] = berg.x + berg.shape.x[i] * cos_ - berg.shape.y[i] * sin_
        berg.vertices.y[i] = berg.y + berg.shape.x[i] * sin_ + berg.shape.y[i] * cos_
    end
end

"""
    potential_energy(berg::Iceberg2D, ocean::Ocean, g=9.81)

Computes potential energy of iceberg in the current configuration.
"""
function potential_energy(berg::Iceberg2D, ocean::Ocean, g=9.81)
    update_vertices!(berg)

    zeta = berg.y
    V = area(berg.shape) * berg.length

    submerged_shape = submerged(berg.vertices, ocean.surface_height)
    xs, ys = centroid(submerged_shape)
    V_sub = area(submerged_shape) * berg.length

    zeta_sub = V_sub < 1.0e-08 ? 0 : ys 

    return g * (berg.density * zeta * V - ocean.density * zeta_sub * V_sub)
end

"""
    potential_energy(y::Real, theta::Real, berg::Iceberg2D, ocean::Ocean, g=9.81)

Computes potential energy of iceberg when berg.y = y and berg.theta = theta.
"""
function potential_energy(y::Real, theta::Real, berg::Iceberg2D, ocean::Ocean, g=9.81)
    berg.y = y
    berg.theta = theta
    return potential_energy(berg, ocean, g)
end
