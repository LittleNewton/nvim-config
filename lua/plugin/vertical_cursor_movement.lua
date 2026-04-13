-- Vertical cursor movement: encode numbers 1-199 as letter sequences
-- using digits: o=0 a=1 r=2 s=3 t=4 d=5 h=6 n=7 e=8 i=9
-- [ prefix + encoded number + <leader> → Nk (up)
-- ' prefix + encoded number + <leader> → Nj (down)

local digit_chars = { "o", "a", "r", "s", "t", "d", "h", "n", "e", "i" }

local function encode(n)
    if n < 10 then
        return digit_chars[n + 1]
    end
    local result = ""
    while n > 0 do
        result = digit_chars[(n % 10) + 1] .. result
        n = math.floor(n / 10)
    end
    return result
end

local opts = { noremap = true }
for n = 1, 199 do
    local code = encode(n)
    vim.keymap.set({ "n", "v" }, "[" .. code .. "<leader>", n .. "k", opts)
    vim.keymap.set({ "n", "v" }, "'" .. code .. "<leader>", n .. "j", opts)
end
