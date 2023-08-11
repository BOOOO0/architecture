package best.server.server.contents.service;

import best.server.server.contents.domain.Content;
import best.server.server.contents.repository.ContentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


public class ContentService {
    private final ContentRepository contentRepository;

    public ContentService(ContentRepository contentRepository){
        this.contentRepository = contentRepository;
    }

    public Long save(Content content){
        contentRepository.save(content);
        return content.getId();
    }

    public List<Content> findAll(){
        return contentRepository.findAll();
    }
}
