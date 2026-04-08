module Icebergs

export 
    Polygon, Rectangle,
    area, centroid,

    Iceberg2D,
    potential_energy, update_vertices!,

    Ocean,
    default_ocean

include("ocean.jl")
include("polygon.jl")

# iceberg2d uses types and methods defined in ocean.jl and polygon.jl
include("iceberg2d.jl")

end # module Icebergs