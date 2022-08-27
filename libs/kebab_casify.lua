local kebab_casify = function(str)
    return str:lower():gsub('?', 'QMARK'):gsub('/', '\n'):gsub(':', ''):gsub('-', ' '):gsub('%p', ''):gsub(' ', '-'):gsub('\n', '/'):gsub('QMARK', '?')
end

return kebab_casify
