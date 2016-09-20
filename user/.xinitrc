export GTK_IM_MODULE="scim"
export QT_IM_MODULE="scim"
export XMODIFIERS='@im=SCIM'
export LC_CTYPE=sv_SE.UTF-8
scim -d
exec ratpoison
