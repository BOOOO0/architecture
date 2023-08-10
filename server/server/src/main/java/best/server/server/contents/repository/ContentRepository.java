package best.server.server.contents.repository;

import best.server.server.contents.domain.Content;

import java.util.List;

public interface ContentRepository {
    Content save(Content content);
    List<Content> findAll();
}
