module Icebergs

export 
    Polygon, Rectangle,
    area, centroid,

    Iceberg2D,
    potential_energy, update_vertices!

    Ocean

include("iceberg2d.jl")
include("ocean.jl")
include("polygon.jl")

end # module Icebergs