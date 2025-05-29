local ls = require('luasnip')
local extra = require('luasnip.extras')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local l = extra.lambda

local math_mode = require('utils.inline_latex_check').check_at_cursor
local not_math_mode = function() return not math_mode() end

return {
  -- Symbols
  s({ trig = '\\sum', wordTrig = false, condition = math_mode },
    { t({ '\\sum_{' }), i(1, 'i'), t({ '=' }), i(2, '1'), t({ '}^{' }), i(3, 'N'), t({ '} ' }), i(0) }),
  s({ trig = '\\prod', wordTrig = false, condition = math_mode },
    { t({ '\\prod_{' }), i(1, 'i'), t({ '=' }), i(2, '1'), t({ '}^{' }), i(3, 'N'), t({ '} ' }), i(0) }),

  -- Derivatives and integrals
  s({ trig = 'par', wordTrig = false, condition = math_mode },
    { t({ '\\frac{ \\partial ' }), i(1, 'y'), t({ ' }{ \\partial ' }), i(2, 'x'), t({ ' } ' }), i(0) }),
  s({ trig = 'pa([A-Za-z])([A-Za-z])', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { t({ '\\frac{ \\partial ' }), l(l.CAPTURE1), t({ ' }{ \\partial ' }), l(l.CAPTURE2), t({ ' } ' }) }),
  s({ trig = '\\int', wordTrig = false, condition = math_mode },
    { t({ '\\int ' }), i(1), t({ ' \\, d' }), i(2, 'x'), t({ ' ' }), i(0) }),
}, {

  -- Math mode
  s({ trig = 'mk', wordTrig = false, condition = not_math_mode }, { t({ '$' }), i(0), t({ '$' }) }),
  s({ trig = 'dm', wordTrig = false, condition = not_math_mode }, { t({ '$$' }), i(0), t({ '$$' }) }),
  s({ trig = 'beg', wordTrig = false, condition = math_mode },
    { t({ '\\begin{' }), i(1), t({ '}' }), i(0), t({ '\\end{' }), i(1), t({ '}' }) }),

  -- Greek letters
  s({ trig = '@a', wordTrig = false, condition = math_mode }, { t({ '\\alpha' }) }),
  s({ trig = '@b', wordTrig = false, condition = math_mode }, { t({ '\\beta' }) }),
  s({ trig = '@g', wordTrig = false, condition = math_mode }, { t({ '\\gamma' }) }),
  s({ trig = '@G', wordTrig = false, condition = math_mode }, { t({ '\\Gamma' }) }),
  s({ trig = '@d', wordTrig = false, condition = math_mode }, { t({ '\\delta' }) }),
  s({ trig = '@D', wordTrig = false, condition = math_mode }, { t({ '\\Delta' }) }),
  s({ trig = '@e', wordTrig = false, condition = math_mode }, { t({ '\\epsilon' }) }),
  s({ trig = ':e', wordTrig = false, condition = math_mode }, { t({ '\\varepsilon' }) }),
  s({ trig = '@z', wordTrig = false, condition = math_mode }, { t({ '\\zeta' }) }),
  s({ trig = '@t', wordTrig = false, condition = math_mode }, { t({ '\\theta' }) }),
  s({ trig = '@T', wordTrig = false, condition = math_mode }, { t({ '\\Theta' }) }),
  s({ trig = ':t', wordTrig = false, condition = math_mode }, { t({ '\\vartheta' }) }),
  s({ trig = '@i', wordTrig = false, condition = math_mode }, { t({ '\\iota' }) }),
  s({ trig = '@k', wordTrig = false, condition = math_mode }, { t({ '\\kappa' }) }),
  s({ trig = '@l', wordTrig = false, condition = math_mode }, { t({ '\\lambda' }) }),
  s({ trig = '@L', wordTrig = false, condition = math_mode }, { t({ '\\Lambda' }) }),
  s({ trig = '@s', wordTrig = false, condition = math_mode }, { t({ '\\sigma' }) }),
  s({ trig = '@S', wordTrig = false, condition = math_mode }, { t({ '\\Sigma' }) }),
  s({ trig = '@u', wordTrig = false, condition = math_mode }, { t({ '\\upsilon' }) }),
  s({ trig = '@U', wordTrig = false, condition = math_mode }, { t({ '\\Upsilon' }) }),
  s({ trig = '@o', wordTrig = false, condition = math_mode }, { t({ '\\omega' }) }),
  s({ trig = '@O', wordTrig = false, condition = math_mode }, { t({ '\\Omega' }) }),
  s({ trig = 'ome', wordTrig = false, condition = math_mode }, { t({ '\\omega' }) }),
  s({ trig = 'Ome', wordTrig = false, condition = math_mode }, { t({ '\\Omega' }) }),

  -- Text environment
  s({ trig = 'text', wordTrig = false, condition = math_mode }, { t({ '\\text{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = '"', wordTrig = false, condition = math_mode }, { t({ '\\text{' }), i(1), t({ '}' }), i(0) }),

  -- Basic operations
  s({ trig = 'sr', wordTrig = false, condition = math_mode }, { t({ '^{2}' }) }),
  s({ trig = 'cb', wordTrig = false, condition = math_mode }, { t({ '^{3}' }) }),
  s({ trig = 'rd', wordTrig = false, condition = math_mode }, { t({ '^{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = '_', wordTrig = false, condition = math_mode }, { t({ '_{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'sts', wordTrig = false, condition = math_mode }, { t({ '_\\text{' }), i(0), t({ '}' }) }),
  s({ trig = 'sq', wordTrig = false, condition = math_mode }, { t({ '\\sqrt{ ' }), i(1), t({ ' }' }), i(0) }),
  s(
    {
      trig = '([a-zA-Z0-9_-{}\\^\\\\]+)\\/',
      wordTrig = false,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { t({ '\\dfrac{' }), l(l.CAPTURE1), t({ '}{' }), i(1), t({ '}' }), i(0) }),
  s(
    {
      trig = '(\\(.+\\))/',
      wordTrig = false,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { f(function(_, snip)
      local match = snip.captures[1] ---@type string
      local length = match:len()
      local lastParen = 1
      local parenCount = 0
      for j = length, 1, -1 do
        local char = match:sub(j, j)
        if char == ')' then
          parenCount = parenCount + 1
        elseif char == '(' then
          parenCount = parenCount - 1
          lastParen = j
        end
        if parenCount == 0 then
          break
        end
      end
      return match:sub(1, lastParen - 1) ..
          '\\dfrac{' .. match:sub(lastParen + 1, length - 1) .. '}{'
    end), i(1), t({ '}' }), i(0) }),
  s({ trig = 'ee', wordTrig = false, condition = math_mode }, { t({ 'e^{ ' }), i(1), t({ ' }' }), i(0) }),
  s({ trig = 'invs', wordTrig = false, condition = math_mode }, { t({ '^{-1}' }) }),
  s(
    { trig = '([A-Za-z])(\\d)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma', priority = -1 },
    { l(l.CAPTURE1), t({ '_{' }), l(l.CAPTURE2), t({ '}' }) }),
  s({ trig = '([^\\\\])(exp|ln)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2) }),
  s({ trig = '([^\\\\])(log)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2), t({ '_{' }), i(0), t({ '}' }) }),
  s({ trig = 'conj', wordTrig = false, condition = math_mode }, { t({ '^{*}' }) }),
  s({ trig = 'Re', wordTrig = false, condition = math_mode }, { t({ '\\mathrm{Re}' }) }),
  s({ trig = 'Im', wordTrig = false, condition = math_mode }, { t({ '\\mathrm{Im}' }) }),
  s({ trig = 'bf', wordTrig = false, condition = math_mode }, { t({ '\\mathbf{' }), i(0), t({ '}' }) }),
  s({ trig = 'rm', wordTrig = false, condition = math_mode }, { t({ '\\mathrm{' }), i(1), t({ '}' }), i(0) }),

  -- Linear algebra
  s({ trig = '([^\\\\])(det)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2) }),
  s({ trig = 'trace', wordTrig = false, condition = math_mode }, { t({ '\\mathrm{Tr}' }) }),

  -- More operations
  s({ trig = '([a-zA-Z])hat', wordTrig = false, condition = math_mode }, { t({ '\\hat{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])bar', wordTrig = false, condition = math_mode }, { t({ '\\bar{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])dot', wordTrig = false, condition = math_mode, priority = -1 },
    { t({ '\\dot{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])ddot', wordTrig = false, condition = math_mode, priority = 1 },
    { t({ '\\ddot{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])tilde', wordTrig = false, condition = math_mode },
    { t({ '\\tilde{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])und', wordTrig = false, condition = math_mode },
    { t({ '\\underline{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])vec', wordTrig = false, condition = math_mode }, { t({ '\\vec{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z]),\\.', wordTrig = false, condition = math_mode },
    { t({ '\\mathbf{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '([a-zA-Z])\\.,', wordTrig = false, condition = math_mode },
    { t({ '\\mathbf{' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}),\\.', wordTrig = false, condition = math_mode },
    { t({ '\\boldsymbol{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK})\\.,', wordTrig = false, condition = math_mode },
    { t({ '\\boldsymbol{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = 'hat', wordTrig = false, condition = math_mode }, { t({ '\\hat{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'bar', wordTrig = false, condition = math_mode }, { t({ '\\bar{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'dot', wordTrig = false, condition = math_mode, priority = -1 }, { t({ '\\dot{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'ddot', wordTrig = false, condition = math_mode }, { t({ '\\ddot{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'cdot', wordTrig = false, condition = math_mode }, { t({ '\\cdot' }) }),
  s({ trig = 'tilde', wordTrig = false, condition = math_mode }, { t({ '\\tilde{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'und', wordTrig = false, condition = math_mode }, { t({ '\\underline{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = 'vec', wordTrig = false, condition = math_mode }, { t({ '\\vec{' }), i(1), t({ '}' }), i(0) }),

  -- More auto letter subscript
  s({ trig = '([A-Za-z])_(\\d\\d)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '_{' }), l(l.CAPTURE2), t({ '}' }) }),
  s({ trig = '\\\\hat{([A-Za-z])}(\\d)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { t({ '\\hat{' }), l(l.CAPTURE1), t({ '}_{' }), l(l.CAPTURE2), t({ '}' }) }),
  s({ trig = '\\\\vec{([A-Za-z])}(\\d)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { t({ '\\vec{' }), l(l.CAPTURE1), t({ '}_{' }), l(l.CAPTURE2), t({ '}' }) }),
  s(
    { trig = '\\\\mathbf{([A-Za-z])}(\\d)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { t({ '\\mathbf{' }), l(l.CAPTURE1), t({ '}_{' }), l(l.CAPTURE2), t({ '}' }) }),
  s({ trig = 'xnn', wordTrig = false, condition = math_mode }, { t({ 'x_{n}' }) }),
  s({ trig = '\\xii', wordTrig = false, condition = math_mode, priority = 1 }, { t({ 'x_{i}' }) }),
  s({ trig = 'xjj', wordTrig = false, condition = math_mode }, { t({ 'x_{j}' }) }),
  s({ trig = 'xp1', wordTrig = false, condition = math_mode }, { t({ 'x_{n+1}' }) }),
  s({ trig = 'ynn', wordTrig = false, condition = math_mode }, { t({ 'y_{n}' }) }),
  s({ trig = 'yii', wordTrig = false, condition = math_mode }, { t({ 'y_{i}' }) }),
  s({ trig = 'yjj', wordTrig = false, condition = math_mode }, { t({ 'y_{j}' }) }),

  -- Symbols
  s({ trig = 'ooo', wordTrig = false, condition = math_mode }, { t({ '\\infty' }) }),
  s({ trig = 'sum', wordTrig = false, condition = math_mode }, { t({ '\\sum' }) }),
  s({ trig = 'prod', wordTrig = false, condition = math_mode }, { t({ '\\prod' }) }),
  s({ trig = 'lim', wordTrig = false, condition = math_mode },
    { t({ '\\lim_{ ' }), i(1, 'n'), t({ ' \\to ' }), i(2, '\\infty'), t({ ' } ' }), i(0) }),
  s({ trig = '+-', wordTrig = false, condition = math_mode }, { t({ '\\pm' }) }),
  s({ trig = '-+', wordTrig = false, condition = math_mode }, { t({ '\\mp' }) }),
  s({ trig = '...', wordTrig = false, condition = math_mode }, { t({ '\\dots' }) }),
  s({ trig = 'nabl', wordTrig = false, condition = math_mode }, { t({ '\\nabla' }) }),
  s({ trig = 'del', wordTrig = false, condition = math_mode }, { t({ '\\nabla' }) }),
  s({ trig = 'xx', wordTrig = false, condition = math_mode }, { t({ '\\times' }) }),
  s({ trig = '**', wordTrig = false, condition = math_mode }, { t({ '\\cdot' }) }),
  s({ trig = 'para', wordTrig = false, condition = math_mode }, { t({ '\\parallel' }) }),
  s({ trig = '===', wordTrig = false, condition = math_mode }, { t({ '\\equiv' }) }),
  s({ trig = '!=', wordTrig = false, condition = math_mode }, { t({ '\\neq' }) }),
  s({ trig = '>=', wordTrig = false, condition = math_mode }, { t({ '\\geq' }) }),
  s({ trig = '<=', wordTrig = false, condition = math_mode }, { t({ '\\leq' }) }),
  s({ trig = '\\leq>', wordTrig = false, condition = math_mode }, { t({ '\\Leftrightarrow' }) }),
  s({ trig = '>>', wordTrig = false, condition = math_mode }, { t({ '\\gg' }) }),
  s({ trig = '<<', wordTrig = false, condition = math_mode }, { t({ '\\ll' }) }),
  s({ trig = 'simm', wordTrig = false, condition = math_mode }, { t({ '\\sim' }) }),
  s({ trig = 'sim=', wordTrig = false, condition = math_mode }, { t({ '\\simeq' }) }),
  s({ trig = 'prop', wordTrig = false, condition = math_mode }, { t({ '\\propto' }) }),
  s({ trig = '<->', wordTrig = false, condition = math_mode }, { t({ '\\leftrightarrow ' }) }),
  s({ trig = '->', wordTrig = false, condition = math_mode }, { t({ '\\to' }) }),
  s({ trig = '!>', wordTrig = false, condition = math_mode }, { t({ '\\mapsto' }) }),
  s({ trig = '=>', wordTrig = false, condition = math_mode }, { t({ '\\implies' }) }),
  s({ trig = '=<', wordTrig = false, condition = math_mode }, { t({ '\\impliedby' }) }),
  s({ trig = 'and', wordTrig = false, condition = math_mode }, { t({ '\\cap' }) }),
  s({ trig = 'orr', wordTrig = false, condition = math_mode }, { t({ '\\cup' }) }),
  s({ trig = 'inn', wordTrig = false, condition = math_mode }, { t({ '\\in' }) }),
  s({ trig = 'notin', wordTrig = false, condition = math_mode }, { t({ '\\not\\in' }) }),
  s({ trig = '\\\\\\', wordTrig = false, condition = math_mode }, { t({ '\\setminus' }) }),
  s({ trig = 'sub', wordTrig = false, condition = math_mode }, { t({ '\\subset' }) }),
  s({ trig = 'su=', wordTrig = false, condition = math_mode }, { t({ '\\subseteq' }) }),
  s({ trig = 'sup=', wordTrig = false, condition = math_mode }, { t({ '\\supseteq' }) }),
  s({ trig = 'eset', wordTrig = false, condition = math_mode }, { t({ '\\emptyset' }) }),
  s({ trig = 'set', wordTrig = false, condition = math_mode }, { t({ '\\{ ' }), i(1), t({ ' \\}' }), i(0) }),
  s({ trig = 'e\\xi sts', wordTrig = false, condition = math_mode, priority = 1 }, { t({ '\\exists' }) }),
  s({ trig = 'LL', wordTrig = false, condition = math_mode }, { t({ '\\mathcal{L}' }) }),
  s({ trig = 'HH', wordTrig = false, condition = math_mode }, { t({ '\\mathcal{H}' }) }),
  s({ trig = 'CC', wordTrig = false, condition = math_mode }, { t({ '\\mathbb{C}' }) }),
  s({ trig = 'RR', wordTrig = false, condition = math_mode }, { t({ '\\mathbb{R}' }) }),
  s({ trig = 'ZZ', wordTrig = false, condition = math_mode }, { t({ '\\mathbb{Z}' }) }),
  s({ trig = 'NN', wordTrig = false, condition = math_mode }, { t({ '\\mathbb{N}' }) }),

  -- Handle spaces and backslashes
  s({ trig = '([^\\\\])(${GREEK})', wordTrig = false, condition = math_mode },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2) }),
  s({ trig = '([^\\\\])(${SYMBOL})', wordTrig = false, condition = math_mode },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2) }),

  -- Insert space after Greek letters and symbols
  s({ trig = '\\\\(${GREEK}|${SYMBOL}|${MORE_SYMBOLS})([A-Za-z])', wordTrig = false, condition = math_mode },
    { t({ '\\' }), l(l.CAPTURE1), t({ ' ' }), l(l.CAPTURE2) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) sr', wordTrig = false, condition = math_mode },
    { t({ '\\' }), l(l.CAPTURE1), t({ '^{2}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) cb', wordTrig = false, condition = math_mode },
    { t({ '\\' }), l(l.CAPTURE1), t({ '^{3}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) rd', wordTrig = false, condition = math_mode },
    { t({ '\\' }), l(l.CAPTURE1), t({ '^{' }), i(1), t({ '}' }), i(0) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) hat', wordTrig = false, condition = math_mode },
    { t({ '\\hat{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) dot', wordTrig = false, condition = math_mode },
    { t({ '\\dot{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) bar', wordTrig = false, condition = math_mode },
    { t({ '\\bar{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) vec', wordTrig = false, condition = math_mode },
    { t({ '\\vec{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) tilde', wordTrig = false, condition = math_mode },
    { t({ '\\tilde{\\' }), l(l.CAPTURE1), t({ '}' }) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) und', wordTrig = false, condition = math_mode },
    { t({ '\\underline{\\' }), l(l.CAPTURE1), t({ '}' }) }),

  -- Derivatives and integrals
  s({ trig = 'ddt', wordTrig = false, condition = math_mode }, { t({ '\\frac{d}{dt} ' }) }),
  s(
    { trig = '([^\\\\])int', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma', priority = -1 },
    { l(l.CAPTURE1), t({ '\\int' }) }),
  s({ trig = 'dint', wordTrig = false, condition = math_mode },
    { t({ '\\int_{' }), i(1, '0'), t({ '}^{' }), i(2, '1'), t({ '} ' }), i(3), t({ ' \\, d' }), i(4, 'x'), t({ ' ' }), i(0) }),
  s({ trig = 'oint', wordTrig = false, condition = math_mode }, { t({ '\\oint' }) }),
  s({ trig = 'iint', wordTrig = false, condition = math_mode }, { t({ '\\iint' }) }),
  s({ trig = 'iiint', wordTrig = false, condition = math_mode }, { t({ '\\iiint' }) }),
  s({ trig = 'oinf', wordTrig = false, condition = math_mode },
    { t({ '\\int_{0}^{\\infty} ' }), i(1), t({ ' \\, d' }), i(2, 'x'), t({ ' ' }), i(0) }),
  s({ trig = 'infi', wordTrig = false, condition = math_mode },
    { t({ '\\int_{-\\infty}^{\\infty} ' }), i(1), t({ ' \\, d' }), i(2, 'x'), t({ ' ' }), i(0) }),

  -- Trigonometry
  s({ trig = '([^\\\\])(sen)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '\\sin' }) }),
  s({ trig = '([^\\\\])(tg)', wordTrig = false, condition = math_mode, regTrig = true, trigEngine = 'ecma' },
    { l(l.CAPTURE1), t({ '\\tan' }) }),
  s(
    {
      trig = '([^\\\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)',
      wordTrig = false,
      condition = math_mode,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { l(l.CAPTURE1), t({ '\\' }), l(l.CAPTURE2) }),
  s(
    {
      trig = '\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-gi-z])',
      wordTrig = false,
      condition = math_mode,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { t({ '\\' }), l(l.CAPTURE1), t({ ' ' }), l(l.CAPTURE2) }),
  s(
    {
      trig = '\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([0-9])',
      wordTrig = false,
      condition = math_mode,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { t({ '\\' }), l(l.CAPTURE1), t({ '^{' }), l(l.CAPTURE2), t({ '} ' }) }),
  s(
    {
      trig = '\\\\(sinh|cosh|tanh|coth)([A-Za-z])',
      wordTrig = false,
      condition = math_mode,
      regTrig = true,
      trigEngine =
      'ecma'
    },
    { t({ '\\' }), l(l.CAPTURE1), t({ ' ' }), l(l.CAPTURE2) }),

  -- Visual operations
  -- s({ trig = 'U', wordTrig = false, condition = math_mode }, { t({ '\\underbrace{ ${VISUAL} }_{ ' }), i(0), t({ ' }' }) }),
  -- s({ trig = 'O', wordTrig = false, condition = math_mode }, { t({ '\\overbrace{ ${VISUAL} }^{ ' }), i(0), t({ ' }' }) }),
  -- s({ trig = 'B', wordTrig = false, condition = math_mode }, { t({ '\\boxed{${VISUAL}}' }), i(0) }),
  -- s({ trig = 'C', wordTrig = false, condition = math_mode }, { t({ '\\cancel{ ${VISUAL} }' }) }),
  -- s({ trig = 'K', wordTrig = false, condition = math_mode }, { t({ '\\cancelto{ ' }), i(0), t({ ' }{ ${VISUAL} }' }) }),
  -- s({ trig = 'S', wordTrig = false, condition = math_mode }, { t({ '\\sqrt{ ${VISUAL} }' }) }),
  -- s({ trig = 'D', wordTrig = false, condition = math_mode }, { t({ '\\dfrac{${VISUAL}}{' }), i(0), t({ '}' }) }),

  -- Physics
  s({ trig = 'kbt', wordTrig = false, condition = math_mode }, { t({ 'k_{B}T' }) }),
  s({ trig = 'msun', wordTrig = false, condition = math_mode }, { t({ 'M_{\\odot}' }) }),

  -- Quantum mechanics
  s({ trig = 'dag', wordTrig = false, condition = math_mode }, { t({ '^{\\dagger}' }) }),
  s({ trig = 'o+', wordTrig = false, condition = math_mode }, { t({ '\\oplus ' }) }),
  s({ trig = 'ox', wordTrig = false, condition = math_mode }, { t({ '\\otimes ' }) }),
  s({ trig = 'bra', wordTrig = false, condition = math_mode }, { t({ '\\bra{' }), i(1), t({ '} ' }), i(0) }),
  s({ trig = 'ket', wordTrig = false, condition = math_mode }, { t({ '\\ket{' }), i(1), t({ '} ' }), i(0) }),
  s({ trig = 'brk', wordTrig = false, condition = math_mode },
    { t({ '\\braket{ ' }), i(1), t({ ' | ' }), i(2), t({ ' } ' }), i(0) }),
  s({ trig = 'outer', wordTrig = false, condition = math_mode },
    { t({ '\\ket{' }), i(1, '\\psi'), t({ '} \\bra{' }), i(1, '\\psi'), t({ '} ' }), i(0) }),

  -- Chemistry
  s({ trig = 'pu', wordTrig = false, condition = math_mode }, { t({ '\\pu{ ' }), i(0), t({ ' }' }) }),
  s({ trig = 'cee', wordTrig = false, condition = math_mode }, { t({ '\\ce{ ' }), i(0), t({ ' }' }) }),
  s({ trig = 'he4', wordTrig = false, condition = math_mode }, { t({ '{}^{4}_{2}He ' }) }),
  s({ trig = 'he3', wordTrig = false, condition = math_mode }, { t({ '{}^{3}_{2}He ' }) }),
  s({ trig = 'iso', wordTrig = false, condition = math_mode },
    { t({ '{}^{' }), i(1, '4'), t({ '}_{' }), i(2, '2'), t({ '}' }), i(0, 'He') }),

  -- Environments
  s({ trig = 'pmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{pmatrix}' }), i(0), t({ '\\end{pmatrix}' }) }),
  s({ trig = 'bmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{bmatrix}' }), i(0), t({ '\\end{bmatrix}' }) }),
  s({ trig = 'Bmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{Bmatrix}' }), i(0), t({ '\\end{Bmatrix}' }) }),
  s({ trig = 'vmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{vmatrix}' }), i(0), t({ '\\end{vmatrix}' }) }),
  s({ trig = 'Vmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{Vmatrix}' }), i(0), t({ '\\end{Vmatrix}' }) }),
  s({ trig = 'matrix', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{matrix}' }), i(0), t({ '\\end{matrix}' }) }),
  s({ trig = 'pmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{pmatrix}' }), i(0), t({ '\\end{pmatrix}' }) }),
  s({ trig = 'bmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{bmatrix}' }), i(0), t({ '\\end{bmatrix}' }) }),
  s({ trig = 'Bmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{Bmatrix}' }), i(0), t({ '\\end{Bmatrix}' }) }),
  s({ trig = 'vmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{vmatrix}' }), i(0), t({ '\\end{vmatrix}' }) }),
  s({ trig = 'Vmat', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{Vmatrix}' }), i(0), t({ '\\end{Vmatrix}' }) }),
  s({ trig = 'matrix', wordTrig = false, condition = not_math_mode },
    { t({ '\\begin{matrix}' }), i(0), t({ '\\end{matrix}' }) }),
  s({ trig = 'cases', wordTrig = false, condition = math_mode },
    { t({ '\\begin{cases}' }), i(0), t({ '\\end{cases}' }) }),
  s({ trig = 'align', wordTrig = false, condition = math_mode },
    { t({ '\\begin{align}' }), i(0), t({ '\\end{align}' }) }),
  s({ trig = 'array', wordTrig = false, condition = math_mode },
    { t({ '\\begin{array}{' }), i(1), t({ '}', '\\\\' }), i(0), t({ '\\end{array}' }) }),
  s({ trig = 'arr ', wordTrig = false, condition = math_mode },
    { t({ '\\begin{array}', '\\\\' }), i(0), t({ '\\end{array}' }) }),

  -- Brackets
  s({ trig = 'avg', wordTrig = false, condition = math_mode }, { t({ '\\langle ' }), i(1), t({ ' \\rangle ' }), i(0) }),
  s({ trig = 'norm', wordTrig = false, condition = math_mode, priority = 1 },
    { t({ '\\lvert ' }), i(1), t({ ' \\rvert ' }), i(0) }),
  s({ trig = 'Norm', wordTrig = false, condition = math_mode, priority = 1 },
    { t({ '\\lVert ' }), i(1), t({ ' \\rVert ' }), i(0) }),
  s({ trig = 'ceil', wordTrig = false, condition = math_mode }, { t({ '\\lceil ' }), i(1), t({ ' \\rceil ' }), i(0) }),
  s({ trig = 'floor', wordTrig = false, condition = math_mode }, { t({ '\\lfloor ' }), i(1), t({ ' \\rfloor ' }), i(0) }),
  s({ trig = 'mod', wordTrig = false, condition = math_mode }, { t({ '|' }), i(1), t({ '|' }), i(0) }),
  -- s({ trig = '(', wordTrig = false, condition = math_mode }, { t({ '(${VISUAL})' }) }),
  -- s({ trig = '[', wordTrig = false, condition = math_mode }, { t({ '[${VISUAL}]' }) }),
  -- s({ trig = '{', wordTrig = false, condition = math_mode }, { t({ '{${VISUAL}}' }) }),
  -- s({ trig = '(', wordTrig = false, condition = math_mode }, { t({ '(' }), i(1), t({ ')' }), i(0) }),
  -- s({ trig = '{', wordTrig = false, condition = math_mode }, { t({ '{' }), i(1), t({ '}' }), i(0) }),
  -- s({ trig = '[', wordTrig = false, condition = math_mode }, { t({ '[' }), i(1), t({ ']' }), i(0) }),
  s({ trig = 'lr(', wordTrig = false, condition = math_mode }, { t({ '\\left( ' }), i(1), t({ ' \\right) ' }), i(0) }),
  s({ trig = 'lr{', wordTrig = false, condition = math_mode }, { t({ '\\left\\{ ' }), i(1), t({ ' \\right\\} ' }), i(0) }),
  s({ trig = 'lr[', wordTrig = false, condition = math_mode }, { t({ '\\left[ ' }), i(1), t({ ' \\right] ' }), i(0) }),
  s({ trig = 'lr|', wordTrig = false, condition = math_mode }, { t({ '\\left| ' }), i(1), t({ ' \\right| ' }), i(0) }),
  s({ trig = 'lra', wordTrig = false, condition = math_mode }, { t({ '\\left< ' }), i(1), t({ ' \\right> ' }), i(0) }),

  -- Snippet replacements can have placeholders.
  s({ trig = 'tayl', wordTrig = false, condition = math_mode },
    { i(1, 'f'), t({ '(' }), i(2, 'x'), t({ ' + ' }), i(3, 'h'), t({ ') = ' }), i(1, 'f'), t({ '(' }), i(2, 'x'), t({
      ') + ' }), i(1, 'f'), t({ '\'(' }), i(2, 'x'), t({ ')' }), i(3, 'h'), t({ ' + ' }), i(1, 'f'), t({ '\'\'(' }), i(2,
      'x'), t({ ') \\frac{' }), i(3, 'h'), t({ '^{2}}{2!} + \\dots' }), i(0) }),
}
