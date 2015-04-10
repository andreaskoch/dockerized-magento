FROM debian:latest

# Install Solr
RUN apt-get update -qy && \
	apt-get install -qy wget openjdk-7-jre && \
	wget http://archive.apache.org/dist/lucene/solr/4.9.1/solr-4.9.1.tgz && \
	tar -xvf solr-4.9.1.tgz -C /usr/local && \
	rm solr-4.9.1.tgz && \
	apt-get -qy purge wget && \
	apt-get clean && \
	rm -rf /tmp/*

# Configure Solr
ENV SOLRPATH /usr/local/solr-4.9.1/example
COPY conf/* $SOLRPATH/solr/collection1/conf/

WORKDIR $SOLRPATH

EXPOSE 8983
CMD ["/usr/bin/java", "-Xmx1024m", "-DSTOP.PORT=55101", "-DSTOP.KEY=stop-jetty-solr", "-jar", "start.jar"]
