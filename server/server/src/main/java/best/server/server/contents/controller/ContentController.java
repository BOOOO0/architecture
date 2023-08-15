package best.server.server.contents.controller;

import best.server.server.contents.domain.Content;
import best.server.server.contents.service.ContentService;
import lombok.AllArgsConstructor;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(path = "/")
@AllArgsConstructor
public class ContentController {
    private final ContentService contentService;

    @PostMapping
    @Transactional
    public void saveContent(@RequestBody Content content) {
        contentService.save(content);
    }

    @GetMapping("/content")
    public List<Content> getContent(){
            return contentService.findAll();
    }
}
