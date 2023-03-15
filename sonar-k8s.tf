resource "kubernetes_namespace" "sonar" {
  metadata {
    name = "sonar"
  }
}

resource "helm_release" "postgresql" {
  depends_on = [
    kubernetes_namespace.sonar
  ]
  namespace  = "sonar"
  name       = "postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "12.2.3"
  timeout    = 1600

  values = [
    "${file("postgresql-values.yaml")}"
  ]
}

resource "helm_release" "sonarqube" {
  depends_on = [
    helm_release.postgresql,
    kubernetes_namespace.sonar
  ]
  namespace  = "sonar"
  name       = "sonarqube"
  repository = "https://SonarSource.github.io/helm-chart-sonarqube"
  chart      = "sonarqube"
  version    = "8.0.0+463"
  timeout    = 1600

  values = [
    "${file("sonarqube-values.yaml")}"
  ]
}

