# corpops-template-repository

[![terraform](https://img.shields.io/badge/terraform-v0.12.X-5C4EE5.svg)](https://www.terraform.io)

[![gradle](https://img.shields.io/badge/gradle-v5.5.X-yellow.svg)](https://gradle.org/install/)
[![maven](https://img.shields.io/badge/maven-v3.6.X-red.svg)](https://maven.apache.org/)

[![node](https://img.shields.io/badge/node-v11.3.X-yellow.svg)](https://nodejs.org)
[![npm](https://img.shields.io/badge/npm-v6.6.X-red.svg)](https://www.npmjs.com/)
[![yarn](https://img.shields.io/badge/yarn-v1.6.X-red.svg)](https://www.yarn.com/)

[![angular-cli](https://img.shields.io/badge/angular.cli-v7.1.X-blue.svg)](https://cli.angular.io/)
[![ionic](https://img.shields.io/badge/ionic.cli-v5.2.X-blue.svg)](https://ionicframework.com)


[![python](https://img.shields.io/badge/python-v3.7.X-green.svg)](https://www.python.org/)
[![pip](https://img.shields.io/badge/pip-v10.0.X-yellow.svg)](https://pypi.org/project/pip/)
[![virtualenv](https://img.shields.io/badge/virtualenv-v15.1.X-red.svg)](https://virtualenv.pypa.io/en/stable/)

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Quickstart](#quickstart)
- [Contributing](#contributing)
- [Further Reading / Useful Links](#further-reading--useful-links)

## Prerequisites

You will need the following things properly installed on your computer:

* [Lorem ipsum dolor sit amet](http://lorem-ipsum-dolor-sit-amet)
* [Lorem ipsum dolor sit amet](http://lorem-ipsum-dolor-sit-amet)
* [Lorem ipsum dolor sit amet](http://lorem-ipsum-dolor-sit-amet)

## Installation

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

## Quickstart

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

## Contributing

If you find this repo useful here's how you can help:

1. Send a Pull Request with your awesome new features and bug fixes
2. Wait for a Coronita :beer: you deserve it.

## Further Reading / Useful Links

* Lorem ipsum dolor sit amet, consectetur adipiscing elit.
* Lorem ipsum dolor sit amet, consectetur adipiscing elit.


* 2. Creacion del vpc_logs 
```terraform
terraform apply -target=module.vpc_logs
```
* 3. Creacion de la vpc 
```terraform
terraform apply -target=module.vpc
```
* 4. Creacion bucket s3_logs_alb 
```terraform
*** terraform apply --target=module.lb_internal.aws_s3_bucket.s3_bucket_internal_logs
```

* 5. Politicas de acceso a bucket s3_logs 
```terraform
terraform apply --target=module.lb_internal.aws_s3_bucket_object.internal
```

* 6. Creacion del balanceador interno 
```terraform
terraform apply --target=module.lb_internal.aws_lb.application
```

* 7. Creacion de la zona privada 
```terraform
terraform apply --target aws_route53_zone.private_jks_vpn
```