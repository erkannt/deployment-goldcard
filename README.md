## Findings

### Kustomize

Instead of templating yaml files kustomize has an understanding of the resources it is manipulating.
This seems to lead to several benefits:

- reduces `label` `selector` boilerplate as `commonLabels` covers all of this
- `commonLabels` encourages meaningful grouping of manifests into 'components'
- `namePrefix` help encapsulate concerns e.g. manifest can just call things `cache` or `app`
- `configMapGenerator` and `secretGenerator` lets one express env-vars in a familiar syntax while kustomize takes care of translation to k8s
- `base` convention and kustomize's abilities encourage good separation of configuration and manifests

Downsides I have found to this approach:

It seems hard to express coupling between domain names in ingress and configuration. The `replacements` feature of kustomize might make this possible but it feels a lot more hairy than helm (or other) templating.
The same goes for coupling between env vars and service names.

### envFrom

`envFrom` is something I strongly suggest we adopt as it leads to very nice encapsulation and separates the responsibility of how to get a secret into the cluster from how to use it.

In combination with `configMapGenerator` and `secretGenerator` it nicely hides how to go from an env-file to having them available inside a container.
