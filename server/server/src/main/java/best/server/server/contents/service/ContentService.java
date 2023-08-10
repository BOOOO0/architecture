package best.server.server.contents.service;

import best.server.server.contents.domain.Content;
import best.server.server.contents.repository.ContentRepository;

public class ContentService {
    private final ContentRepository contentRepository;

    public ContentService(ContentRepository contentRepository){
        this.contentRepository = contentRepository;
    }

    public Long save(Content content){
        contentRepository.save(content);
        return content.getId();
    }
}
