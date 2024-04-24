

导入子仓库
1. 方法1,科学上网【容易】
```shell
source  /app/wiki/computer/bash_completion/bash_completion-gitproxy.md.sh
#gitproxy <两次tab> 有如下提示，根据需要修改，获得：
git config --global http.proxy socks5://westgw:7890 ; 
git config --global https.proxy socks5://westgw:7890  ; 
git clone -b v5.0.0 --recurse-submodules https://github.com/qemu/qemu.git  ;    
git config --global --unset http.proxy ; 
git config --global --unset https.proxy
```

2. 方法2,迁移gitlab到gitee、本地gitea伪装为gitlab【麻烦】
```shell
source /app/github-gitee-GITEA/gitee_api_fetch_ts/script/bash-complete--import_githubRepo_to_gitee.sh


# https://gitlab.com/qemu-project/seabios.git
# https://gitlab.com/qemu-project/SLOF.git
# https://gitlab.com/qemu-project/ipxe.git
# https://gitlab.com/qemu-project/openbios.git
# https://gitlab.com/qemu-project/qemu-palcode.git
# https://gitlab.com/qemu-project/sgabios.git
# https://gitlab.com/qemu-project/dtc.git
# https://gitlab.com/qemu-project/u-boot.git
# https://gitlab.com/qemu-project/skiboot.git
# https://gitlab.com/qemu-project/QemuMacDrivers.git
# https://gitlab.com/qemu-project/keycodemapdb.git
# https://gitlab.com/qemu-project/capstone.git
# https://gitlab.com/qemu-project/seabios-hppa.git
# https://gitlab.com/qemu-project/u-boot-sam460ex.git
# https://gitlab.com/qemu-project/berkeley-testfloat-3.git
# https://gitlab.com/qemu-project/berkeley-softfloat-3.git
# https://gitlab.com/qemu-project/edk2.git
# https://gitlab.com/qemu-project/libslirp.git
# https://gitlab.com/qemu-project/opensbi.git
# https://github.com/bonzini/qboot.git


alias alias_import_githubRepo_to_gitee='sleep 4; import_githubRepo_to_gitee.sh --from_repo https://gitlab.com/qemu-project/$name.git   --goal_org imagg  --goal_repoPath qemu-project--$name --goal_repoName qemu-project--$name --goal_repoDesc desc_qemu-project--$name  --write_return  ret.json'

set -x
name=seabios; alias_import_githubRepo_to_gitee
name=SLOF; alias_import_githubRepo_to_gitee
name=ipxe; alias_import_githubRepo_to_gitee
name=openbios; alias_import_githubRepo_to_gitee
name=qemu-palcode; alias_import_githubRepo_to_gitee
name=sgabios; alias_import_githubRepo_to_gitee
name=dtc; alias_import_githubRepo_to_gitee
name=u-boot; alias_import_githubRepo_to_gitee
name=skiboot; alias_import_githubRepo_to_gitee
name=QemuMacDrivers; alias_import_githubRepo_to_gitee
name=keycodemapd; alias_import_githubRepo_to_giteeB
name=capstone; alias_import_githubRepo_to_gitee
name=seabios-hppa; alias_import_githubRepo_to_gitee
name=u-boot-sam460ex; alias_import_githubRepo_to_gitee
name=berkeley-testfloat-3; alias_import_githubRepo_to_gitee
name=berkeley-softfloat-3; alias_import_githubRepo_to_gitee
name=edk2; alias_import_githubRepo_to_gitee
name=libslirp; alias_import_githubRepo_to_gitee
name=opensbi; alias_import_githubRepo_to_gitee
import_githubRepo_to_gitee.sh --from_repo https://github.com/bonzini/qboot.git   --goal_org imagg  --goal_repoPath bonzini--qboot --goal_repoName bonzini--qboot --goal_repoDesc desc_bonzini--qboot  --write_return  ret.json

#未完，还需要本地gitea伪装为gitlab、github【很麻烦】
```