FROM h2oai/h2o-open-source-k8s:3.30.1.1
EXPOSE 54321
RUN wget https://s3.us-west-1.amazonaws.com/ai.h2o.tests/intermittent_files/h2o_3.32.0.2.jar
RUN wget https://s3.us-west-1.amazonaws.com/ai.h2o.tests/intermittent_files/h2o-jetty-9-3.35.0.jar
COPY hash.login /hash.login
WORKDIR /
ENTRYPOINT ["/bin/bash", "-c", "java -XX:+UseContainerSupport -XX:MaxRAMPercentage=50 -cp /h2o-jetty-9-3.35.0.jar:/h2o_3.32.0.2.jar water.H2OApp -form_auth -hash_login -login_conf /hash.login -user_name test123"]
