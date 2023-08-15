package best.server.server;

import best.server.server.contents.repository.ContentRepository;
import best.server.server.contents.repository.MemoryContentRepository;
import best.server.server.contents.service.ContentService;
import jakarta.persistence.EntityManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class SpringConfig {

    private EntityManager em;

    @Autowired
    public SpringConfig(EntityManager em){
        this.em = em;
    }
    @Bean
    public ContentService contentService(){
        return new ContentService(contentRepository());
    }

    @Bean
    public ContentRepository contentRepository(){
        return new MemoryContentRepository(em);
    }
}
