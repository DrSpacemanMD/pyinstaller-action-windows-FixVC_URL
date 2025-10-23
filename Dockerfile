FROM jackmckew/pyinstaller-windows

#extra winetrick step to fix "Unimplemented function ucrtbase.dll.crealf called"
RUN apt-get install -y xvfb libgnutls30 libgnutls30:i386
ADD https://aka.ms/vs/17/release/vc_redist.x86.exe /tmp/vc_redist.x86.exe
RUN xvfb-run wine /tmp/vc_redist.x86.exe /quiet /install
RUN xvfb-run winetricks --force -q vcrun2019

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
