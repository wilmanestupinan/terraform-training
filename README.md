cbpop-template-repo
terraform

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

Table of Contents
Prerequisites
Installation
Quickstart
Contributing
Further Reading / Useful Links
Prerequisites
You will need the following things properly installed on your computer:

Lorem ipsum dolor sit amet
Lorem ipsum dolor sit amet
Lorem ipsum dolor sit amet
Installation
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

Quickstart
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec venenatis, lacus a pretium euismod, turpis dolor viverra velit, sit amet laoreet justo ante at sem. Pellentesque sollicitudin, mi mollis mollis convallis, felis velit fermentum libero, ut blandit elit mi vel risus. Sed augue metus, scelerisque nec pretium ac, bibendum facilisis massa.

Contributing
If you find this repo useful here's how you can help:

Send a Pull Request with your awesome new features and bug fixes
Wait for a Coronita 🍺 you deserve it.
Further Reading / Useful Links
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Lorem ipsum dolor sit amet, consectetur adipiscing elit.
Providers
Name	Version
github	n/a
Inputs
Name	Description	Type	Default	Required
github_organization	GitHub parent Organization when new repository can create	string	n/a	yes
github_token	Token de Github para establecer la comunicacion	string	n/a	yes
region	Region de aws donde se encuentra hospedados los recursos	string	n/a	yes
repositories_name	Lista de los nombres de repositorios a actualizar	list(string)	n/a	yes
team_description	Descripcion del equipo	string	n/a	yes
team_name	Nombre del equipo a crear	string	n/a	yes
usernames	Lista de los nombres de usuarios que ya debe estar en la organizacion	list(string)	n/a	yes
team_permission	Tipo de permiso a otorgar al usuario: pull, push, maintain, triage o admin	string	"push"	no
team_privacy	Tipo de privacidad del equipo secret o closed	string	"secret"	no
user_role	Tipo del rol del usuario a agregar en el equipo member o maintainer	string	"member"	no
Outputs
No output.