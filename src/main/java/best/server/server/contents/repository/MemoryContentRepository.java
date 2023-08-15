package best.server.server.contents.repository;

import best.server.server.contents.domain.Content;
import jakarta.persistence.EntityManager;
import org.springframework.stereotype.Repository;

import java.util.List;


public class MemoryContentRepository implements ContentRepository{
    private final EntityManager em;

    public MemoryContentRepository(EntityManager em){
        this.em = em;
    }
    @Override
    public Content save(Content content) {
        em.persist(content);
        return content;
    }

    @Override
    public List<Content> findAll() {
        // MySQL에서 명시한 Relation의 이름은 content 대소문자를 구분하지 않는다.
        // domain 패키지에서 명시한 Entity의 이름은 Content, 스프링은 대소문자를 구분한다.
        // Entity의 이름으로 명시해야 한다.
        return em.createQuery("SELECT text FROM Content", Content.class).getResultList();
    }
}
