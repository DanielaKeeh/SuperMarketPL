% ============================================================
%   LAYOUT TEMPLATE — Wrapper de fragmentos SSR
% ============================================================

:- module(layout, [render_layout/4]).

render_layout(_Titulo, Breadcrumb, ContenidoHTML, HTML) :-
    atomic_list_concat([
        '<div class="page-body" data-breadcrumb="', Breadcrumb, '">',
        ContenidoHTML,
        '</div>'
    ], HTML).