#Data Visualization with Makie.jl
using CairoMakie
CairoMakie.activate!()

fig = scatterlines(1:10, 1:10)
pltobj.attributes

#6.3.4 Figure + Axis + plot + axislegend
function figure_axis_plot_leg()
    fig = Figure(;
        figure_padding=(5,5,10,10),
        backgroundcolor=:snow2,
        size=(600,400),
        )
    ax = Axis(fig[1,1];
        xlabel="x",
        ylabel="y",
        title="Title",
        xgridstyle=:dash,
        ygridstyle=:dash,
        )
    lines!(ax, 0.5:0.2:3pi, x -> cos(x)/x;
        linewidth=2,
        linestyle=:solid,
        label = "cos(x)/x",
        )
    scatterlines!(ax, 0.5:0.2:3pi, x -> -cos(x)/x;
        color=:black,
        linewidth=2,
        linestyle=:dash,
         label = "-cos(x)/x",
        )
    axislegend("legend"; position=:rt)
    fig
end
figure_axis_plot_leg() #JDS.figure_axis_plot() = erreur dans tuto 

#6.3.5 Figure + Axis + plot + Legend + Colorbar
using Random: seed!
seed!(28)
xyz = randn(100, 3)
xyz[1:4, :]

function fig_bubbles(xyz)
    fig = Figure(size=(600,400))
    ax = Axis(fig[1,1]; aspect = DataAspect())
    pltobj = scatter!(xyz[:, 1], xyz[:, 2];
        color=xyz[:, 3],
        label="Bubbles",
        colormap=:plasma,
        markersize=15 * abs.(xyz[:, 3]),
        )
    limits!(-3, 3, -3, 3)
    Legend(fig[1, 2], ax, valign=:top)
    Colorbar(fig[1, 2], pltobj, height=Relative(3/4))
    fig
end
fig_bubbles(xyz)

#6.5 Themes
using Distributions
function demo_figure()
    # contourf
    x=y= range(-2.3, 2.3, length=100)
    z=-2x .* exp.(-x .^ 2 .- (y') .^ 2)
    # density
    μσpairs=[[4,2],[2,0.5],[-1,2],[0.25,1],[-4, 2],[8, 1.5]]
    # lines
    xs=range(0, 4π, 100)
    ys=[sin.(xs),cos.(xs),-sin.(xs),-cos.(xs),0.5cos.(xs),-0.5cos.(xs)]
    labs=["sin(x)","cos(x)","-sin(x)","-cos(x)","cos(x)/2","-cos(x)/2"]
    # figure
    fig = Figure(figure_padding=(10,15,5,35),
        size = (900,600), fontsize = 20)
    ax1 = Axis(fig[1,1]; xlabel="x", ylabel="y")
    ax2 = Axis(fig[1,2]; xlabel="x", ylabel="pdf")
    ax3 = Axis(fig[2,1:2]; xlabel="x", ylabel="y")
    obj = contourf!(ax1, x,y,z; levels=30)
    Colorbar(fig[1,1, Top()], obj;
        vertical=false,
        tellheight=false,
        tellwidth=false,
        valign=:top
        )
    for μσ in μσpairs
        density!(ax2, rand(Distributions.Normal(μσ...),1000);
            label="$(μσ[1]),$(μσ[2])")
    end
    Legend(fig[1,2, Top()], ax2;
        orientation=:horizontal,
        nbanks=2,
        backgroundcolor =:transparent,
        tellheight=false,
        valign=:center,
        )
    limits!(ax2, -10,15,0,1)
    [lines!(ax3, xs, y, label = "$(labs[i])") for (i,y) in enumerate(ys)]
    limits!(ax3, 0,4π,-1,1)
    Legend(fig[2,1:2, Top()], ax3, orientation=:horizontal)
    fig
end
demo_figure()

function peaks(; n=49)
    x = range(-3, 3, n)
    y = range(-3, 3, n)
    a = 3 * (1 .- x') .^ 2 .* exp.(-(x' .^ 2) .- (y .+ 1) .^ 2)
    b = 10 * (x' / 5 .- x' .^ 3 .- y .^ 5) .* exp.(-x' .^ 2 .- y .^ 2)
    c = 1 / 3 * exp.(-(x' .+ 1) .^ 2 .- y .^ 2)
    return (x, y, a .- b .- c)
end
function heatmap_contour_and_contourf()
    x, y, z = peaks()
    fig = Figure(size=(1200, 400))
    axs = [Axis(fig[1, i]; aspect=DataAspect()) for i = 1:3]
    hm = heatmap!(axs[1], x, y, z)
    contour!(axs[2], x, y, z; levels=20)
    contourf!(axs[3], x, y, z)
    Colorbar(fig[1, 4], hm, height=Relative(0.5))
    fig
end
heatmap_contour_and_contourf()

#6.10 A Makie recipe for a DataFrame
@recipe(DfPlot, df) do scene
    Attributes(
        x = :A,
        y = :B,
        c = :C,
        color = :red,
        colormap = :plasma,
        markersize = 20,
        marker = :rect,
        colorrange = (0,1),
        label = "",
    )
end

function Makie.plot!(p::DfPlot{<:Tuple{<:DataFrame}})
    df = p[:df][]
    x = getproperty(df, p[:x][])
    y = getproperty(df, p[:y][])
    c = getproperty(df, p[:c][])
    scatter!(p, x, y; color = c, markersize = p[:markersize][],
        colormap = p[:colormap][], marker = p[:marker][],
        colorrange = (minimum(x), maximum(c)), label = p[:label][])
    return p
end
df_recipe = DataFrame(A=randn(10), B=randn(10), C=rand(10))
fig, ax, obj = dfplot(df_recipe; label = "test")
axislegend()
Colorbar(fig[1,2], obj)
fig
df_names = DataFrame(a1=rand(100), a2=rand(100), a3=rand(100))
dfplot(df_names; x = :a1, y = :a2, c = :a3, marker = 'o',
    axis = (; aspect=1, xlabel = "a1", ylabel = "a2"),
    figure = (; backgroundcolor = :grey90))