# @TEST-EXEC: ${DIST}/aux/bro-aux/plugin-support/init-plugin Demo Foo
# @TEST-EXEC: bash %INPUT
# @TEST-EXEC: make BRO=${DIST}
# @TEST-EXEC: BROPLUGINS=`pwd` bro -NN | awk '/^Plugin:.*Demo/ {p=1; print; next} /^Plugin:/{p=0} p==1{print}' >>output
# @TEST-EXEC: echo === >>output
# @TEST-EXEC: BROPLUGINS=`pwd` bro -r $TRACES/empty.trace >>output
# @TEST-EXEC: echo === >>output
# @TEST-EXEC: BROPLUGINS=`pwd` bro demo/foo -r $TRACES/empty.trace >>output
# @TEST-EXEC: btest-diff output

cat >scripts/__load__.bro <<EOF
@load ./demo/foo/base/at-startup.bro
EOF

cat >scripts/demo/foo/__load__.bro <<EOF
@load ./manually.bro
EOF

cat >scripts/demo/foo/manually.bro <<EOF
event bro_init()
        {
        print "plugin: manually loaded";
        }
EOF

mkdir -p scripts/demo/foo/base/

cat >scripts/demo/foo/base/at-startup.bro <<EOF
event bro_init()
        {
        print "plugin: automatically loaded at startup";
        print "calling bif", hello_plugin_world();
        }
EOF

cat >src/functions.bif <<EOF
function hello_plugin_world%(%): string
        %{
        return new StringVal("Hello from the plugin!");
        %}
EOF

cat >src/events.bif <<EOF
event plugin_event%(foo: count%);
EOF
