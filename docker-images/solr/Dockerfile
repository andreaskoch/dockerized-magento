FROM debian:latest

# Install Solr 3.6
RUN apt-get update -qy && \
	apt-get install -qy wget openjdk-7-jre && \
	wget http://archive.apache.org/dist/lucene/solr/3.6.2/apache-solr-3.6.2.tgz && \
	tar -xvf apache-solr-3.6.2.tgz -C /usr/local && \
	rm apache-solr-3.6.2.tgz && \
	apt-get -qy purge wget && \
	apt-get clean && \
	rm -rf /tmp/*

# Configure Solr
ENV SOLRPATH /usr/local/apache-solr-3.6.2/example
COPY conf/solr $SOLRPATH/solr/conf/

WORKDIR $SOLRPATH

EXPOSE 8983
CMD ["/usr/bin/java", "-Xmx1024m", "-DSTOP.PORT=55101", "-DSTOP.KEY=stop-jetty-solr", "-jar", "start.jar"]
