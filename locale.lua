function TSL(key, ...)
    local selected = Locales[(type(Config) == 'table' and Config.Locale) or 'nl'] or {}
    local value = selected[key] or (Locales.nl or {})[key] or key
    if select('#', ...) > 0 then return value:format(...) end
    return value
end
