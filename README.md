# raspifarm

Prerequisites: Ansible

## Ansible Playbooks

Login with farmer user, run the **master** playbook

```shell
ansible-playbook -i ~/raspifarm/ansible/raspifarm-inventory ~/raspifarm/ansible/playbooks/raspifarm-master-essentials.yml
```

Login with farmer user, run the **slaves** playbook

```shell
ansible-playbook -i ~/raspifarm/ansible/raspifarm-inventory ~/raspifarm/ansible/playbooks/raspifarm-slaves-essentials.yml
```
