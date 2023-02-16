using CitableBase, CitableText, CitableCorpus
f = joinpath(pwd(), "data", "oeconomicus.cex")
c = fromcex(f, CitableTextCorpus, FileReader)

basedir = joinpath(pwd(), "sandbox", "passages")
browsedir = joinpath(pwd(), "sandbox", "browsable")
readerdir = joinpath(pwd(), "sandbox", "reader")

for (i,psg) in enumerate(c.passages)
    prev = if i == 1
        ""
    else
        "[[browse " * passagecomponent(c.passages[i - 1].urn) *  "]]"
    end
    nxt = if i == length(c.passages)
        ""
    else
       "[[browse " * passagecomponent(c.passages[i + 1].urn) *  "]]"
    end

    fname = passagecomponent(psg.urn) * ".md"
    newfile = joinpath(basedir, fname) 
    open(newfile, "w") do io
        write(io, psg.text)
    end

    browsablefile = joinpath(browsedir, "browse " * fname)
    ref = passagecomponent(psg.urn)
    contents = [prev * " ☚ : ☛ " * nxt,
        "![[$(ref)]]"
    ]
    open(browsablefile, "w") do io
        write(io, join(contents, "\n\n") * "\n\n")
    end
    

    readerfile = joinpath(browsedir, "reader " * fname)
    readerlines = [prev * " ☚ : ☛ " * nxt,
    "[[$(ref)]]"
    "## Commentary",
    "![[commentary $(ref)]]",

  "## Vocabulary",
    "![[vocab $(ref)]]",


    "## Syntax",
    "![[syntax $(ref)]]",
    ""
    ]
    open(readerfile, "w") do io
        write(io, join(contreaderlinesents, "\n\n") )
    end 
end