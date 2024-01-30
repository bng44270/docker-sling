FROM debian:latest

RUN apt-get update
RUN apt-get install -y openjdk-17-jdk curl gawk unzip iproute2
RUN eval $(curl -s https://dlcdn.apache.org/sling/ | \
	awk '/<a href="org.apache.sling.feature.launcher-[0-9\.]+\.zip">/ { printf("SLING_LAUNCHER=\"%s\"\n",gensub(/^.*<a href="([^"]+)">.*$/,"\\1","g",$0)); }/<a href="org.apache.sling.starter-[0-9]+-oak_tar_far.far">/ { printf("OAK_FAR=\"%s\"\n",gensub(/^.*<a href="([^"]+)">.*$/,"\\1","g",$0)); }' \
	) \
	&& curl https://dlcdn.apache.org/sling/$SLING_LAUNCHER > /root/$SLING_LAUNCHER \
	&& curl https://dlcdn.apache.org/sling/$OAK_FAR > /root/$OAK_FAR

RUN cd /root && unzip *zip
COPY startup.sh /root
RUN chmod +x /root/startup.sh
ENTRYPOINT ["/root/startup.sh"]
