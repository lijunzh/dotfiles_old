" Neomake
" ---------
let g:neomake_open_list = 0
let g:neomake_verbose = 1

" YAML / ANSIBLE
let g:neomake_yaml_enabled_makers = ['yamllint']
let g:neomake_ansible_enabled_makers = ['yamllint']
let g:neomake_ansible_yamllint_maker = neomake#makers#ft#yaml#yamllint()

" SHELL
let g:neomake_shellcheck_args = ['-xfgcc']
