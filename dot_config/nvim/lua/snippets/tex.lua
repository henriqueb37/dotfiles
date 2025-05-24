local ls = require('luasnip')
local extra = require('luasnip.extras')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local l = extra.lambda

local math_mode = require('utils.inline_latex_check').check_at_cursor
local not_math_mode = function() return not math_mode() end

return {

  -- Symbols
  s({ trig = '\\sum', condition = math_mode }, { t({'\\sum_{'}), i(1, 'i'), t({'='}), i(2, '1'), t({'}^{'}), i(3, 'N'), t({'} '}), i(0) }),
  s({ trig = '\\prod', condition = math_mode }, { t({'\\prod_{'}), i(1, 'i'), t({'='}), i(2, '1'), t({'}^{'}), i(3, 'N'), t({'} '}), i(0) }),

  -- Derivatives and integrals
  s({ trig = 'par', condition = math_mode }, { t({'\\frac{ \\partial '}), i(1, 'y'), t({' }{ \\partial '}), i(2, 'x'), t({' } '}), i(0) }),
  s({ trig = 'pa([A-Za-z])([A-Za-z])', regTrig = true, trigEngine = 'ecma' }, { t({'\\frac{ \\partial '}), l(l.CAPTURE1), t({' }{ \\partial '}), l(l.CAPTURE2), t({' } '}) }),
  s({ trig = '\\int', condition = math_mode }, { t({'\\int '}), i(1), t({' \\, d'}), i(2, 'x'), t({' '}), i(0) }),
}, {

  -- Math mode
  s({ trig = 'mk', condition = not_math_mode }, { t({'$'}), i(0), t({'$'}) }),
  s({ trig = 'dm', condition = not_math_mode }, { t({'$$', ''}), i(0), t({'', '$$'}) }),
  s({ trig = 'beg', condition = math_mode }, { t({'\\begin{'}), i(1), t({'}', ''}), i(0), t({'', '\\end{'}), i(1), t({'}'}) }),

  -- Greek letters
  s({ trig = '@a', condition = math_mode }, { t({'\\alpha'}) }),
  s({ trig = '@b', condition = math_mode }, { t({'\\beta'}) }),
  s({ trig = '@g', condition = math_mode }, { t({'\\gamma'}) }),
  s({ trig = '@G', condition = math_mode }, { t({'\\Gamma'}) }),
  s({ trig = '@d', condition = math_mode }, { t({'\\delta'}) }),
  s({ trig = '@D', condition = math_mode }, { t({'\\Delta'}) }),
  s({ trig = '@e', condition = math_mode }, { t({'\\epsilon'}) }),
  s({ trig = ':e', condition = math_mode }, { t({'\\varepsilon'}) }),
  s({ trig = '@z', condition = math_mode }, { t({'\\zeta'}) }),
  s({ trig = '@t', condition = math_mode }, { t({'\\theta'}) }),
  s({ trig = '@T', condition = math_mode }, { t({'\\Theta'}) }),
  s({ trig = ':t', condition = math_mode }, { t({'\\vartheta'}) }),
  s({ trig = '@i', condition = math_mode }, { t({'\\iota'}) }),
  s({ trig = '@k', condition = math_mode }, { t({'\\kappa'}) }),
  s({ trig = '@l', condition = math_mode }, { t({'\\lambda'}) }),
  s({ trig = '@L', condition = math_mode }, { t({'\\Lambda'}) }),
  s({ trig = '@s', condition = math_mode }, { t({'\\sigma'}) }),
  s({ trig = '@S', condition = math_mode }, { t({'\\Sigma'}) }),
  s({ trig = '@u', condition = math_mode }, { t({'\\upsilon'}) }),
  s({ trig = '@U', condition = math_mode }, { t({'\\Upsilon'}) }),
  s({ trig = '@o', condition = math_mode }, { t({'\\omega'}) }),
  s({ trig = '@O', condition = math_mode }, { t({'\\Omega'}) }),
  s({ trig = 'ome', condition = math_mode }, { t({'\\omega'}) }),
  s({ trig = 'Ome', condition = math_mode }, { t({'\\Omega'}) }),

  -- Text environment
  s({ trig = 'text', condition = math_mode }, { t({'\\text{'}), i(1), t({'}'}), i(0) }),
  s({ trig = '"', condition = math_mode, wordTrig = false }, { t({'\\text{'}), i(1), t({'}'}), i(0) }),

  -- Basic operations
  s({ trig = 'sr', condition = math_mode }, { t({'^{2}'}) }),
  s({ trig = 'cb', condition = math_mode }, { t({'^{3}'}) }),
  s({ trig = 'rd', condition = math_mode }, { t({'^{'}), i(1), t({'}'}), i(0) }),
  s({ trig = '_', condition = math_mode, wordTrig = false }, { t({'_{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'sts', condition = math_mode }, { t({'_\\text{'}), i(0), t({'}'}) }),
  s({ trig = 'sq', condition = math_mode }, { t({'\\sqrt{ '}), i(1), t({' }'}), i(0) }),
  s({ trig = '//', condition = math_mode, wordTrig = false }, { t({'\\frac{'}), i(1), t({'}{'}), i(2), t({'}'}), i(0) }),
  s({ trig = 'ee', condition = math_mode }, { t({'e^{ '}), i(1), t({' }'}), i(0) }),
  s({ trig = 'invs', condition = math_mode }, { t({'^{-1}'}) }),
  s({ trig = '([A-Za-z])(\\d)', regTrig = true, trigEngine = 'ecma', priority = -1 }, { l(l.CAPTURE1), t({'_{'}), l(l.CAPTURE2), t({'}'}) }),
  s({ trig = '([^\\\\])(exp|ln)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2) }),
  s({ trig = '([^\\\\])(log)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2), t({'_{'}), i(0), t({'}'}) }),
  s({ trig = 'conj', condition = math_mode }, { t({'^{*}'}) }),
  s({ trig = 'Re', condition = math_mode }, { t({'\\mathrm{Re}'}) }),
  s({ trig = 'Im', condition = math_mode }, { t({'\\mathrm{Im}'}) }),
  s({ trig = 'bf', condition = math_mode }, { t({'\\mathbf{'}), i(0), t({'}'}) }),
  s({ trig = 'rm', condition = math_mode }, { t({'\\mathrm{'}), i(1), t({'}'}), i(0) }),

  -- Linear algebra
  s({ trig = '([^\\\\])(det)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2) }),
  s({ trig = 'trace', condition = math_mode }, { t({'\\mathrm{Tr}'}) }),

  -- More operations
  s({ trig = '([a-zA-Z])hat', condition = math_mode }, { t({'\\hat{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])bar', condition = math_mode }, { t({'\\bar{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])dot', condition = math_mode, priority = -1 }, { t({'\\dot{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])ddot', condition = math_mode, priority = 1 }, { t({'\\ddot{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])tilde', condition = math_mode }, { t({'\\tilde{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])und', condition = math_mode }, { t({'\\underline{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])vec', condition = math_mode }, { t({'\\vec{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z]),\\.', condition = math_mode }, { t({'\\mathbf{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '([a-zA-Z])\\.,', condition = math_mode }, { t({'\\mathbf{'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}),\\.', condition = math_mode }, { t({'\\boldsymbol{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK})\\.,', condition = math_mode }, { t({'\\boldsymbol{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = 'hat', condition = math_mode }, { t({'\\hat{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'bar', condition = math_mode }, { t({'\\bar{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'dot', condition = math_mode, priority = -1 }, { t({'\\dot{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'ddot', condition = math_mode }, { t({'\\ddot{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'cdot', condition = math_mode }, { t({'\\cdot'}) }),
  s({ trig = 'tilde', condition = math_mode }, { t({'\\tilde{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'und', condition = math_mode }, { t({'\\underline{'}), i(1), t({'}'}), i(0) }),
  s({ trig = 'vec', condition = math_mode }, { t({'\\vec{'}), i(1), t({'}'}), i(0) }),

  -- More auto letter subscript
  s({ trig = '([A-Za-z])_(\\d\\d)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'_{'}), l(l.CAPTURE2), t({'}'}) }),
  s({ trig = '\\\\hat{([A-Za-z])}(\\d)', regTrig = true, trigEngine = 'ecma' }, { t({'\\hat{'}), l(l.CAPTURE1), t({'}_{'}), l(l.CAPTURE2), t({'}'}) }),
  s({ trig = '\\\\vec{([A-Za-z])}(\\d)', regTrig = true, trigEngine = 'ecma' }, { t({'\\vec{'}), l(l.CAPTURE1), t({'}_{'}), l(l.CAPTURE2), t({'}'}) }),
  s({ trig = '\\\\mathbf{([A-Za-z])}(\\d)', regTrig = true, trigEngine = 'ecma' }, { t({'\\mathbf{'}), l(l.CAPTURE1), t({'}_{'}), l(l.CAPTURE2), t({'}'}) }),
  s({ trig = 'xnn', condition = math_mode }, { t({'x_{n}'}) }),
  s({ trig = '\\xii', condition = math_mode, priority = 1 }, { t({'x_{i}'}) }),
  s({ trig = 'xjj', condition = math_mode }, { t({'x_{j}'}) }),
  s({ trig = 'xp1', condition = math_mode }, { t({'x_{n+1}'}) }),
  s({ trig = 'ynn', condition = math_mode }, { t({'y_{n}'}) }),
  s({ trig = 'yii', condition = math_mode }, { t({'y_{i}'}) }),
  s({ trig = 'yjj', condition = math_mode }, { t({'y_{j}'}) }),

  -- Symbols
  s({ trig = 'ooo', condition = math_mode }, { t({'\\infty'}) }),
  s({ trig = 'sum', condition = math_mode }, { t({'\\sum'}) }),
  s({ trig = 'prod', condition = math_mode }, { t({'\\prod'}) }),
  s({ trig = 'lim', condition = math_mode }, { t({'\\lim_{ '}), i(1, 'n'), t({' \\to '}), i(2, '\\infty'), t({' } '}), i(0) }),
  s({ trig = '+-', condition = math_mode, wordTrig = false }, { t({'\\pm'}) }),
  s({ trig = '-+', condition = math_mode, wordTrig = false }, { t({'\\mp'}) }),
  s({ trig = '...', condition = math_mode, wordTrig = false }, { t({'\\dots'}) }),
  s({ trig = 'nabl', condition = math_mode }, { t({'\\nabla'}) }),
  s({ trig = 'del', condition = math_mode }, { t({'\\nabla'}) }),
  s({ trig = 'xx', condition = math_mode }, { t({'\\times'}) }),
  s({ trig = '**', condition = math_mode, wordTrig = false }, { t({'\\cdot'}) }),
  s({ trig = 'para', condition = math_mode }, { t({'\\parallel'}) }),
  s({ trig = '===', condition = math_mode, wordTrig = false }, { t({'\\equiv'}) }),
  s({ trig = '!=', condition = math_mode, wordTrig = false }, { t({'\\neq'}) }),
  s({ trig = '>=', condition = math_mode, wordTrig = false }, { t({'\\geq'}) }),
  s({ trig = '<=', condition = math_mode, wordTrig = false }, { t({'\\leq'}) }),
  s({ trig = '>>', condition = math_mode, wordTrig = false }, { t({'\\gg'}) }),
  s({ trig = '<<', condition = math_mode, wordTrig = false }, { t({'\\ll'}) }),
  s({ trig = 'simm', condition = math_mode }, { t({'\\sim'}) }),
  s({ trig = 'sim=', condition = math_mode }, { t({'\\simeq'}) }),
  s({ trig = 'prop', condition = math_mode }, { t({'\\propto'}) }),
  s({ trig = '<->', condition = math_mode, wordTrig = false }, { t({'\\leftrightarrow '}) }),
  s({ trig = '->', condition = math_mode, wordTrig = false }, { t({'\\to'}) }),
  s({ trig = '!>', condition = math_mode, wordTrig = false }, { t({'\\mapsto'}) }),
  s({ trig = '=>', condition = math_mode, wordTrig = false }, { t({'\\implies'}) }),
  s({ trig = '=<', condition = math_mode, wordTrig = false }, { t({'\\impliedby'}) }),
  s({ trig = 'and', condition = math_mode }, { t({'\\cap'}) }),
  s({ trig = 'orr', condition = math_mode }, { t({'\\cup'}) }),
  s({ trig = 'inn', condition = math_mode }, { t({'\\in'}) }),
  s({ trig = 'notin', condition = math_mode }, { t({'\\not\\in'}) }),
  s({ trig = '\\\\\\', condition = math_mode, wordTrig = false }, { t({'\\setminus'}) }),
  s({ trig = 'sub', condition = math_mode }, { t({'\\subset'}) }),
  s({ trig = 'su=', condition = math_mode }, { t({'\\subseteq'}) }),
  s({ trig = 'sup=', condition = math_mode }, { t({'\\supseteq'}) }),
  s({ trig = 'eset', condition = math_mode }, { t({'\\emptyset'}) }),
  s({ trig = 'set', condition = math_mode }, { t({'\\{ '}), i(1), t({' \\}'}), i(0) }),
  s({ trig = 'e\\xi sts', condition = math_mode, priority = 1 }, { t({'\\exists'}) }),
  s({ trig = 'LL', condition = math_mode }, { t({'\\mathcal{L}'}) }),
  s({ trig = 'HH', condition = math_mode }, { t({'\\mathcal{H}'}) }),
  s({ trig = 'CC', condition = math_mode }, { t({'\\mathbb{C}'}) }),
  s({ trig = 'RR', condition = math_mode }, { t({'\\mathbb{R}'}) }),
  s({ trig = 'ZZ', condition = math_mode }, { t({'\\mathbb{Z}'}) }),
  s({ trig = 'NN', condition = math_mode }, { t({'\\mathbb{N}'}) }),

  -- Handle spaces and backslashes
  s({ trig = '([^\\\\])(${GREEK})', condition = math_mode }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2) }),
  s({ trig = '([^\\\\])(${SYMBOL})', condition = math_mode }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2) }),

  -- Insert space after Greek letters and symbols
  s({ trig = '\\\\(${GREEK}|${SYMBOL}|${MORE_SYMBOLS})([A-Za-z])', condition = math_mode }, { t({'\\'}), l(l.CAPTURE1), t({' '}), l(l.CAPTURE2) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) sr', condition = math_mode }, { t({'\\'}), l(l.CAPTURE1), t({'^{2}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) cb', condition = math_mode }, { t({'\\'}), l(l.CAPTURE1), t({'^{3}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) rd', condition = math_mode }, { t({'\\'}), l(l.CAPTURE1), t({'^{'}), i(1), t({'}'}), i(0) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) hat', condition = math_mode }, { t({'\\hat{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) dot', condition = math_mode }, { t({'\\dot{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) bar', condition = math_mode }, { t({'\\bar{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) vec', condition = math_mode }, { t({'\\vec{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) tilde', condition = math_mode }, { t({'\\tilde{\\'}), l(l.CAPTURE1), t({'}'}) }),
  s({ trig = '\\\\(${GREEK}|${SYMBOL}) und', condition = math_mode }, { t({'\\underline{\\'}), l(l.CAPTURE1), t({'}'}) }),

  -- Derivatives and integrals
  s({ trig = 'ddt', condition = math_mode }, { t({'\\frac{d}{dt} '}) }),
  s({ trig = '([^\\\\])int', regTrig = true, trigEngine = 'ecma', priority = -1 }, { l(l.CAPTURE1), t({'\\int'}) }),
  s({ trig = 'dint', condition = math_mode }, { t({'\\int_{'}), i(1, '0'), t({'}^{'}), i(2, '1'), t({'} '}), i(3), t({' \\, d'}), i(4, 'x'), t({' '}), i(0) }),
  s({ trig = 'oint', condition = math_mode }, { t({'\\oint'}) }),
  s({ trig = 'iint', condition = math_mode }, { t({'\\iint'}) }),
  s({ trig = 'iiint', condition = math_mode }, { t({'\\iiint'}) }),
  s({ trig = 'oinf', condition = math_mode }, { t({'\\int_{0}^{\\infty} '}), i(1), t({' \\, d'}), i(2, 'x'), t({' '}), i(0) }),
  s({ trig = 'infi', condition = math_mode }, { t({'\\int_{-\\infty}^{\\infty} '}), i(1), t({' \\, d'}), i(2, 'x'), t({' '}), i(0) }),

  -- Trigonometry
  s({ trig = '([^\\\\])(sen)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\sin'}) }),
  s({ trig = '([^\\\\])(tg)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\tan'}) }),
  s({ trig = '([^\\\\])(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)', regTrig = true, trigEngine = 'ecma' }, { l(l.CAPTURE1), t({'\\'}), l(l.CAPTURE2) }),
  s({ trig = '\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([A-Za-gi-z])', regTrig = true, trigEngine = 'ecma' }, { t({'\\'}), l(l.CAPTURE1), t({' '}), l(l.CAPTURE2) }),
  s({ trig = '\\\\(arcsin|sin|arccos|cos|arctan|tan|csc|sec|cot)([0-9])', regTrig = true, trigEngine = 'ecma' }, { t({'\\'}), l(l.CAPTURE1), t({'^{'}), l(l.CAPTURE2), t({'} '}) }),
  s({ trig = '\\\\(sinh|cosh|tanh|coth)([A-Za-z])', regTrig = true, trigEngine = 'ecma' }, { t({'\\'}), l(l.CAPTURE1), t({' '}), l(l.CAPTURE2) }),

  -- Visual operations
  s({ trig = 'U', condition = math_mode }, { t({'\\underbrace{ ${VISUAL} }_{ '}), i(0), t({' }'}) }),
  s({ trig = 'O', condition = math_mode }, { t({'\\overbrace{ ${VISUAL} }^{ '}), i(0), t({' }'}) }),
  s({ trig = 'B', condition = math_mode }, { t({'\\boxed{${VISUAL}}'}), i(0) }),
  s({ trig = 'C', condition = math_mode }, { t({'\\cancel{ ${VISUAL} }'}) }),
  s({ trig = 'K', condition = math_mode }, { t({'\\cancelto{ '}), i(0), t({' }{ ${VISUAL} }'}) }),
  s({ trig = 'S', condition = math_mode }, { t({'\\sqrt{ ${VISUAL} }'}) }),
  s({ trig = 'D', condition = math_mode }, { t({'\\dfrac{${VISUAL}}{'}), i(0), t({'}'}) }),

  -- Physics
  s({ trig = 'kbt', condition = math_mode }, { t({'k_{B}T'}) }),
  s({ trig = 'msun', condition = math_mode }, { t({'M_{\\odot}'}) }),

  -- Quantum mechanics
  s({ trig = 'dag', condition = math_mode }, { t({'^{\\dagger}'}) }),
  s({ trig = 'o+', condition = math_mode }, { t({'\\oplus '}) }),
  s({ trig = 'ox', condition = math_mode }, { t({'\\otimes '}) }),
  s({ trig = 'bra', condition = math_mode }, { t({'\\bra{'}), i(1), t({'} '}), i(0) }),
  s({ trig = 'ket', condition = math_mode }, { t({'\\ket{'}), i(1), t({'} '}), i(0) }),
  s({ trig = 'brk', condition = math_mode }, { t({'\\braket{ '}), i(1), t({' | '}), i(2), t({' } '}), i(0) }),
  s({ trig = 'outer', condition = math_mode }, { t({'\\ket{'}), i(1, '\\psi'), t({'} \\bra{'}), i(1, '\\psi'), t({'} '}), i(0) }),

  -- Chemistry
  s({ trig = 'pu', condition = math_mode }, { t({'\\pu{ '}), i(0), t({' }'}) }),
  s({ trig = 'cee', condition = math_mode }, { t({'\\ce{ '}), i(0), t({' }'}) }),
  s({ trig = 'he4', condition = math_mode }, { t({'{}^{4}_{2}He '}) }),
  s({ trig = 'he3', condition = math_mode }, { t({'{}^{3}_{2}He '}) }),
  s({ trig = 'iso', condition = math_mode }, { t({'{}^{'}), i(1, '4'), t({'}_{'}), i(2, '2'), t({'}'}), i(0, 'He') }),

  -- Environments
  s({ trig = 'pmat', condition = not_math_mode }, { t({'\\begin{pmatrix}', ''}), i(0), t({'', '\\end{pmatrix}'}) }),
  s({ trig = 'bmat', condition = not_math_mode }, { t({'\\begin{bmatrix}', ''}), i(0), t({'', '\\end{bmatrix}'}) }),
  s({ trig = 'Bmat', condition = not_math_mode }, { t({'\\begin{Bmatrix}', ''}), i(0), t({'', '\\end{Bmatrix}'}) }),
  s({ trig = 'vmat', condition = not_math_mode }, { t({'\\begin{vmatrix}', ''}), i(0), t({'', '\\end{vmatrix}'}) }),
  s({ trig = 'Vmat', condition = not_math_mode }, { t({'\\begin{Vmatrix}', ''}), i(0), t({'', '\\end{Vmatrix}'}) }),
  s({ trig = 'matrix', condition = not_math_mode }, { t({'\\begin{matrix}', ''}), i(0), t({'', '\\end{matrix}'}) }),
  s({ trig = 'pmat', condition = not_math_mode }, { t({'\\begin{pmatrix}'}), i(0), t({'\\end{pmatrix}'}) }),
  s({ trig = 'bmat', condition = not_math_mode }, { t({'\\begin{bmatrix}'}), i(0), t({'\\end{bmatrix}'}) }),
  s({ trig = 'Bmat', condition = not_math_mode }, { t({'\\begin{Bmatrix}'}), i(0), t({'\\end{Bmatrix}'}) }),
  s({ trig = 'vmat', condition = not_math_mode }, { t({'\\begin{vmatrix}'}), i(0), t({'\\end{vmatrix}'}) }),
  s({ trig = 'Vmat', condition = not_math_mode }, { t({'\\begin{Vmatrix}'}), i(0), t({'\\end{Vmatrix}'}) }),
  s({ trig = 'matrix', condition = not_math_mode }, { t({'\\begin{matrix}'}), i(0), t({'\\end{matrix}'}) }),
  s({ trig = 'cases', condition = math_mode }, { t({'\\begin{cases}', ''}), i(0), t({'', '\\end{cases}'}) }),
  s({ trig = 'align', condition = math_mode }, { t({'\\begin{align}', ''}), i(0), t({'', '\\end{align}'}) }),
  s({ trig = 'array', condition = math_mode }, { t({'\\begin{array}{'}), i(1), t({'}', '\\\\', ''}), i(0), t({'', '\\end{array}'}) }),
  s({ trig = 'arr ', condition = math_mode }, { t({'\\begin{array}', '\\\\', ''}), i(0), t({'', '\\end{array}'}) }),

  -- Brackets
  s({ trig = 'avg', condition = math_mode }, { t({'\\langle '}), i(1), t({' \\rangle '}), i(0) }),
  s({ trig = 'norm', condition = math_mode, priority = 1 }, { t({'\\lvert '}), i(1), t({' \\rvert '}), i(0) }),
  s({ trig = 'Norm', condition = math_mode, priority = 1 }, { t({'\\lVert '}), i(1), t({' \\rVert '}), i(0) }),
  s({ trig = 'ceil', condition = math_mode }, { t({'\\lceil '}), i(1), t({' \\rceil '}), i(0) }),
  s({ trig = 'floor', condition = math_mode }, { t({'\\lfloor '}), i(1), t({' \\rfloor '}), i(0) }),
  s({ trig = 'mod', condition = math_mode }, { t({'|'}), i(1), t({'|'}), i(0) }),
  s({ trig = '(', condition = math_mode, wordTrig = false }, { t({'(${VISUAL})'}) }),
  s({ trig = '[', condition = math_mode, wordTrig = false }, { t({'[${VISUAL}]'}) }),
  s({ trig = '{', condition = math_mode, wordTrig = false }, { t({'{${VISUAL}}'}) }),
  s({ trig = '(', condition = math_mode, wordTrig = false }, { t({'('}), i(1), t({')'}), i(0) }),
  s({ trig = '{', condition = math_mode, wordTrig = false }, { t({'{'}), i(1), t({'}'}), i(0) }),
  s({ trig = '[', condition = math_mode, wordTrig = false }, { t({'['}), i(1), t({']'}), i(0) }),
  s({ trig = 'lr(', condition = math_mode }, { t({'\\left( '}), i(1), t({' \\right) '}), i(0) }),
  s({ trig = 'lr{', condition = math_mode }, { t({'\\left\\{ '}), i(1), t({' \\right\\} '}), i(0) }),
  s({ trig = 'lr[', condition = math_mode }, { t({'\\left[ '}), i(1), t({' \\right] '}), i(0) }),
  s({ trig = 'lr|', condition = math_mode }, { t({'\\left| '}), i(1), t({' \\right| '}), i(0) }),
  s({ trig = 'lra', condition = math_mode }, { t({'\\left< '}), i(1), t({' \\right> '}), i(0) }),

  -- Snippet replacements can have placeholders.
  s({ trig = 'tayl', condition = math_mode }, { i(1, 'f'), t({'('}), i(2, 'x'), t({' + '}), i(3, 'h'), t({') = '}), i(1, 'f'), t({'('}), i(2, 'x'), t({') + '}), i(1, 'f'), t({'\'('}), i(2, 'x'), t({')'}), i(3, 'h'), t({' + '}), i(1, 'f'), t({'\'\'('}), i(2, 'x'), t({') \\frac{'}), i(3, 'h'), t({'^{2}}{2!} + \\dots'}), i(0) }),
}