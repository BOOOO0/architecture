package best.server.server.contents.repository;

import best.server.server.contents.domain.Content;
import jakarta.persistence.EntityManager;

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
        return em.createQuery("SELECT text FROM content", Content.class).getResultList();
    }
}
