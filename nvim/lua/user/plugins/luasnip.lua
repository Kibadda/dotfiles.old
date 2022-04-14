local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged,TextChangedI',
}

local function copy(args)
  return args[1]
end

ls.add_snippets('php', {
  s('class', {
    t('class '), i(1, 'Foo'), t({' {', ''}),
    t('\t'), i(0), t({'', ''}),
    t('}')
  }),
  s('pubf', {
    t('public function '), i(1), t('('), i(2), t('): '), i(3), t({' {', ''}),
    t('\t'), i(0), t({'', ''}),
    t('}')
  }),
  s('prif', {
    t('private function '), i(1), t('('), i(2), t('): '), i(3), t({' {', ''}),
    t('\t'), i(0), t({'', ''}),
    t('}')
  }),
  s('prof', {
    t('protected function '), i(1), t('('), i(2), t('): '), i(3), t({' {', ''}),
    t('\t'), i(0), t({'', ''}),
    t('}')
  }),
  s('get', {
    t('public function get'), i(1), t('(): ?'), i(2), t({' {', ''}),
    t('\treturn $this->'), i(0), t({';', ''}),
    t('}'),
  }),
  s('set', {
    t('public function set'), i(0), t('($'), i(1), t({'): void {', ''}),
    t('\t$this->'), f(copy, 1), t(' = $'), f(copy, 1), t({';', ''}),
    t('}'),
  }),
  s('for', {
    t('foreach ('), i(1), t(' as '), i(2), t({')', ''}),
    t('\t'), i(0), t({'', ''}),
    t('}'),
  }),
})

ls.add_snippets('typescript', {
  s('import', {
    t('import '), i(1), t(' from \''), i(0), t('\';'),
  }),
})
