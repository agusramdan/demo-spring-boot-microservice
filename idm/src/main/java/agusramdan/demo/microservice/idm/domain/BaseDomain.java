package agusramdan.demo.microservice.idm.domain;

import com.fasterxml.jackson.core.SerializableString;

public interface BaseDomain <ID>{

    ID getId();
    void setId(ID id);

}
