oc login -u system:admin
oc new-project weave-scope
# Scope probe pods need full access to Kubernetes API via 'weave-scope' service account
oc adm policy add-cluster-role-to-user cluster-reader -z weave-scope
# Scope probe pods also need to run as priviliaged containers, so grant 'priviliged' Security Context Constrains (SCC) for 'weave-scope' service account
oc adm policy add-scc-to-user privileged -z weave-scope
# Scope traffic control requires hostnetwork scc
# oc adm policy add-scc-to-user hostnetwork -z weave-scope
# Scope app has an init daemon that has to run as UID 0, so grant 'anyuid' SCC for 'default' service account
oc adm policy add-scc-to-user anyuid -z default
oc create -f scope.yaml
oc create -f k8s-traffic-control-yaml
oc expose svc weave-scope-app
