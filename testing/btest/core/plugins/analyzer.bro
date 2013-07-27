# @TEST-EXEC: ${DIST}/aux/bro-aux/plugin-support/init-plugin Demo Foo
# @TEST-EXEC: cp -r %DIR/analyzer-plugin/* .
# @TEST-EXEC: make BRO=${DIST}
# @TEST-EXEC: BROPLUGINS=`pwd` bro -NN | awk '/^Plugin:.*Demo/ {p=1; print; next} /^Plugin:/{p=0} p==1{print}' >>output
# @TEST-EXEC: echo === >>output
# @TEST-EXEC: BROPLUGINS=`pwd` bro -r $TRACES/port4242.trace %INPUT >>output
# @TEST-EXEC: btest-diff output

event foo_message(c: connection, data: string)
	{
	print "foo_message", c$id, data;
	}

