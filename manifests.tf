

resource "kubectl_manifest" "config_map" {

  yaml_body = <<YAML

  apiVersion: v1
  kind: ConfigMap
  metadata:
    name: s3-config
  data:
    S3_REGION: "eu-central-1"
    S3_BUCKET: "NAME OF YOUR BUCKET HERE"
    AWS_KEY: "YOUR AWS KEY"
    AWS_SECRET_KEY: "YOUR SECRET AWS KEY"

YAML

}

resource "kubectl_manifest" "deamonset" {

  yaml_body = <<YAML

  apiVersion: apps/v1
  kind: DaemonSet
  metadata:
    labels:
      app: s3-provider
    name: s3-provider
  spec:
    selector:
      matchLabels:
        app.kubernetes.io/name: s3-provider
    template:
      metadata:
        labels:
          app.kubernetes.io/name: s3-provider
      spec:
        containers:
        - name: s3fuse
          image: meain/s3-mounter
          securityContext:
            privileged: true
          envFrom:
          - configMapRef:
              name: s3-config
          volumeMounts:
          - name: devfuse
            mountPath: /dev/fuse
          - name: mntdatas3fs
            mountPath: /var/s3fs:shared
        volumes:
        - name: devfuse
          hostPath:
            path: /dev/fuse
        - name: mntdatas3fs
          hostPath:
            path: /mnt/s3data

YAML

}
