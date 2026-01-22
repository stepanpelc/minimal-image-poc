# Spring Boot Minimal Images PoC

Dummy Spring Boot application with multiple container image variants for size comparison.

- distroless
- temurin-alpine
- chainguard-jre
- ubi-micro
- temurin-jammy
- jlink-scratch

## Sizes

```bash
IMAGE                                         SIZE
-----                                         ----
demo:poc-chainguard-jre                      428    MB
demo:poc-distroless                          326    MB
demo:poc-jlink-scratch                        8.77  kB
demo:poc-temurin-alpine                      255    MB
demo:poc-temurin-jammy                       373    MB
demo:poc-ubi-micro                            31.8  MB

```

## Trivy scans

From date 22.1.2026

```bash
echo "Scanning demo:poc-distroless"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-distroless;
Scanning demo:poc-distroless
-----------------------------

Report Summary

┌────────────────────────────────────┬────────┬─────────────────┬─────────┐
│               Target               │  Type  │ Vulnerabilities │ Secrets │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-distroless (debian 12.13) │ debian │        0        │    -    │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                            │  jar   │        0        │    -    │
└────────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

[pelc@workstation]~/Sources/github.com/stepanpelc/image-sizes% just scan-all
echo "Scanning demo:poc-distroless"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-distroless;
Scanning demo:poc-distroless
-----------------------------

Report Summary

┌────────────────────────────────────┬────────┬─────────────────┬─────────┐
│               Target               │  Type  │ Vulnerabilities │ Secrets │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-distroless (debian 12.13) │ debian │        0        │    -    │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                            │  jar   │        0        │    -    │
└────────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

[pelc@workstation]~/Sources/github.com/stepanpelc/image-sizes% just scan-all
error: Variable `IMAGE` not defined
  ——▶ justfile:47:19
   │
47 │     echo "Scanning {{IMAGE}}"; \
   │                      ^^^^^
[pelc@workstation]~/Sources/github.com/stepanpelc/image-sizes% just scan-all
just scan demo:poc-distroless
echo "Scanning demo:poc-distroless"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-distroless;
Scanning demo:poc-distroless
-----------------------------

Report Summary

┌────────────────────────────────────┬────────┬─────────────────┬─────────┐
│               Target               │  Type  │ Vulnerabilities │ Secrets │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-distroless (debian 12.13) │ debian │        0        │    -    │
├────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                            │  jar   │        0        │    -    │
└────────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

just scan demo:poc-temurin-alpine
echo "Scanning demo:poc-temurin-alpine"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-temurin-alpine;
Scanning demo:poc-temurin-alpine
-----------------------------

Report Summary

┌─────────────────────────────────────────┬────────┬─────────────────┬─────────┐
│                 Target                  │  Type  │ Vulnerabilities │ Secrets │
├─────────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-temurin-alpine (alpine 3.22.2) │ alpine │       14        │    -    │
├─────────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                                 │  jar   │        0        │    -    │
└─────────────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)


demo:poc-temurin-alpine (alpine 3.22.2)

Total: 14 (HIGH: 14, CRITICAL: 0)

┌──────────────────┬────────────────┬──────────┬────────┬───────────────────┬───────────────┬──────────────────────────────────────────────────────────────┐
│     Library      │ Vulnerability  │ Severity │ Status │ Installed Version │ Fixed Version │                            Title                             │
├──────────────────┼────────────────┼──────────┼────────┼───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ gnupg            │ CVE-2025-68973 │ HIGH     │ fixed  │ 2.4.7-r0          │ 2.4.9-r0      │ GnuPG: GnuPG: Information disclosure and potential arbitrary │
│                  │                │          │        │                   │               │ code execution via out-of-bounds write...                    │
│                  │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-68973                   │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gnupg-dirmngr    │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gnupg-gpgconf    │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gnupg-keyboxd    │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gnupg-utils      │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gnupg-wks-client │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gpg              │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gpg-agent        │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gpg-wks-server   │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gpgsm            │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┤                │          │        │                   │               │                                                              │
│ gpgv             │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
│                  │                │          │        │                   │               │                                                              │
├──────────────────┼────────────────┤          │        ├───────────────────┼───────────────┼──────────────────────────────────────────────────────────────┤
│ libpng           │ CVE-2025-64720 │          │        │ 1.6.47-r0         │ 1.6.51-r0     │ libpng: LIBPNG buffer overflow                               │
│                  │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-64720                   │
│                  ├────────────────┤          │        │                   │               ├──────────────────────────────────────────────────────────────┤
│                  │ CVE-2025-65018 │          │        │                   │               │ libpng: LIBPNG heap buffer overflow                          │
│                  │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-65018                   │
│                  ├────────────────┤          │        │                   ├───────────────┼──────────────────────────────────────────────────────────────┤
│                  │ CVE-2025-66293 │          │        │                   │ 1.6.53-r0     │ libpng: LIBPNG out-of-bounds read in                         │
│                  │                │          │        │                   │               │ png_image_read_composite                                     │
│                  │                │          │        │                   │               │ https://avd.aquasec.com/nvd/cve-2025-66293                   │
└──────────────────┴────────────────┴──────────┴────────┴───────────────────┴───────────────┴──────────────────────────────────────────────────────────────┘
just scan demo:poc-chainguard-jre
echo "Scanning demo:poc-chainguard-jre"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-chainguard-jre;
Scanning demo:poc-chainguard-jre
-----------------------------

Report Summary

┌──────────────────────────────────────────┬───────┬─────────────────┬─────────┐
│                  Target                  │ Type  │ Vulnerabilities │ Secrets │
├──────────────────────────────────────────┼───────┼─────────────────┼─────────┤
│ demo:poc-chainguard-jre (wolfi 20230201) │ wolfi │        0        │    -    │
├──────────────────────────────────────────┼───────┼─────────────────┼─────────┤
│ app.jar                                  │  jar  │        0        │    -    │
└──────────────────────────────────────────┴───────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

just scan demo:poc-ubi-micro
echo "Scanning demo:poc-ubi-micro"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-ubi-micro;
Scanning demo:poc-ubi-micro
-----------------------------

Report Summary

┌─────────────────────────────────┬────────┬─────────────────┬─────────┐
│             Target              │  Type  │ Vulnerabilities │ Secrets │
├─────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-ubi-micro (redhat 9.7) │ redhat │        0        │    -    │
├─────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                         │  jar   │        0        │    -    │
└─────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

just scan demo:poc-temurin-jammy
echo "Scanning demo:poc-temurin-jammy"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-temurin-jammy;
Scanning demo:poc-temurin-jammy
-----------------------------

Report Summary

┌───────────────────────────────────────┬────────┬─────────────────┬─────────┐
│                Target                 │  Type  │ Vulnerabilities │ Secrets │
├───────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ demo:poc-temurin-jammy (ubuntu 22.04) │ ubuntu │        0        │    -    │
├───────────────────────────────────────┼────────┼─────────────────┼─────────┤
│ app.jar                               │  jar   │        0        │    -    │
└───────────────────────────────────────┴────────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)

just scan demo:poc-jlink-scratch
echo "Scanning demo:poc-jlink-scratch"; echo "-----------------------------"; TRIVY_IMAGE_SOURCE=docker trivy image --quiet --severity CRITICAL,HIGH --ignore-unfixed demo:poc-jlink-scratch;
Scanning demo:poc-jlink-scratch
-----------------------------

Report Summary

┌─────────┬──────┬─────────────────┬─────────┐
│ Target  │ Type │ Vulnerabilities │ Secrets │
├─────────┼──────┼─────────────────┼─────────┤
│ app.jar │ jar  │        0        │    -    │
└─────────┴──────┴─────────────────┴─────────┘
Legend:
- '-': Not scanned
- '0': Clean (no security findings detected)



```