"""
Ocean parameters
"""
struct Ocean
    density::Real
    surface_height::Real
end

"""
    default_ocean()

Generate the default ocean parameters.

# Examples
```
julia> ocean = default_ocean()
Ocean(1025.0, 0.0)
```
"""
default_ocean() = Ocean(1025.0, 0.0)
