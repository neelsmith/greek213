#=
Compile a single composite markdown file from a root directory
of markdown files with headers following the conventions of
the JustTheDocs jekyll theme.

Usage:

    julia reviewdoc.jl SRCDIR] [OUTFILE]
=#

srcdir = length(ARGS) > 1 ? ARGS[2] : joinpath(pwd(), "docs","review")
outfile = length(ARGS) > 2 ? ARGS[3] : joinpath(pwd(), "printable","review.md")

#using Pkg
#Pkg.add("UnifyJustTheDocs")
using Pkg
Pkg.activate(".")
Pkg.instantiate()
using UnifyJustTheDocs

hdrlines = readlines("printable/review.yaml")
hdr = join(hdrlines,"\n")

# Create single markdown file
docsmd = composite(srcdir)
md = hdr * docsmd #replace(docsmd, "`" => "")
# Another LaText gotcha:
tidier = replace(md, "-*" => "*")

# Write to disk
open(outfile,"w") do io
    write(io, tidier)
end

