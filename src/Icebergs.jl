module Icebergs

export 
    Polygon, Rectangle,
    area, centroid,

    Iceberg2D,

    Ocean

include("iceberg2d.jl")
include("ocean.jl")
include("polygon.jl")

end # module Icebergs