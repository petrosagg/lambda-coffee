i = 0
uid = 0
cache = {}
numCalls = 0
for k, v of global
    if i > defaultGlobalObjects
        if typeof v == 'function'
            cache[k] = {}
            ((v, k) ->
                global[k] = (x) ->
                    if typeof x.cacheId == 'undefined'
                        x.cacheId = ++uid
                    if typeof cache[k][x.cacheId] == 'undefined'
                        # console.log 'MISS'
                        cache[k][x.cacheId] = v x
                    else
                        # console.log 'HIT'
                    cache[k][x.cacheId]
            )(v, k)
            console.log 'Optimized function: ' + k
    ++i
