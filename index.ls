
{docopt} = require('docopt')
sm       = require('sitemap')
glob     = require('glob')
path     = require('path')

doc = """
Usage:
    sitemap-cli generate DIR -p PREFIX 
    sitemap-cli -h | --help 

Options:
    -p, --prefix PREFIX     Url prefix to be used

Arguments:
    DIR                     Root of the website
"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]

o = docopt(doc)

prefix = get-option('-p' , '--prefix', '', o)
dir = o['DIR']

if prefix != ''
    files = glob.sync("**/*.html", cwd: "#dir/")

    # files = files.map ->
    #     return path.normalize(it)

    files = files.map ->
        return { url: "/#it", changefreq: 'daily', priority: 0.5 }
    opts = {
        hostname: prefix
        cacheTime: 600000
        urls: files
    }
    sitemap = sm.createSitemap(opts)
    sitemap.toXML (xml) ->
        console.log xml

    






