Steffi is a Ruby / [FFI](https://github.com/ffi/ffi/wiki) wrapper around the [igraph library](http://igraph.sourceforge.net/).

This is currently a recreational project for me to learn more about graph algorithms and practice with FFI in advance of my upcoming [ATLRUG](http://www.meetup.com/atlantaruby/events/96069232/) talk. Do not expect it to be feature-complete. If you are interested in higher-level bindings to the igraph, you may want to check out the Python or R packages in the [igraph documentation](http://igraph.sourceforge.net/documentation.html). There do not appear to be maintained Ruby bindings compatible with the current release (0.6).

### Installing igraph

Steffi expects igraph 0.6+. To build igraph from source, [download it](http://igraph.sourceforge.net/download.html) and 

    ./configure
    make
    make install

On OSX, you can also install through homebrew

    brew install igraph 