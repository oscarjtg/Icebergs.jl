# Icebergs.jl Documentation

A package for simulating iceberg dynamics.

```@contents
```

## Types

```@docs
Polygon
```

## Functions

```@docs
area(p::Polygon)
centroid(p::Polygon)
Rectangle(width, height)
update_vertices!(berg::Iceberg2D)
potential_energy(berg::Iceberg2D, ocean::Ocean, g=9.81)
```