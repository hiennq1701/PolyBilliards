package poly.billiards.dao;

import java.util.List;
import poly.billiards.entity.ChatMessage;

public interface ChatMessageDAO {
    void create(ChatMessage message);
    void update(ChatMessage entity);
    void delete(int id);
    void deleteAll();
    ChatMessage findById(int id);
    List<ChatMessage> findAll();
    List<ChatMessage> findBySender(String sender);
    List<ChatMessage> findUnread();
    void markAsRead(int id);
    void markAllAsRead();
} 
