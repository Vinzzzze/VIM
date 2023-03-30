" Vim syntax file
" Language:	C++
" Maintainer:	Ken Shan <ccshan@post.harvard.edu>
" Last Change:	2002 Jul 15

" C++ extentions
syn keyword cppAccess		VM_PUBLIC VM_PROTECTED VM_PRIVATE VM_VIRTUAL
syn keyword cppType		   __inline VM_INLINE VM_CHAR BIG_INT
syn keyword cppIHate       const final override and or xor
syn keyword cConstant      nullptr
syn keyword cError         NULL null

hi cppIHate guifg=Orange guibg=Black ctermfg=2

