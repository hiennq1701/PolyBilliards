package poly.billiards.dao.impl;

import java.util.List;
import poly.billiards.dao.ChatMessageDAO;
import poly.billiards.entity.ChatMessage;
import poly.billiards.util.XJdbc;
import poly.billiards.util.XQuery;

public class ChatMessageDAOImpl implements ChatMessageDAO {
    private static final String INSERT_SQL = "INSERT INTO ChatMessages (SenderUsername, Content, Timestamp, IsRead) VALUES (?, ?, ?, ?)";
    private static final String SELECT_ALL_SQL = "SELECT * FROM ChatMessages ORDER BY Timestamp DESC";
    private static final String DELETE_ALL_SQL = "DELETE FROM ChatMessages";
    private static final String updateSql = "UPDATE ChatMessages SET SenderUsername = ?, Content = ?, Timestamp = ?, IsRead = ? WHERE ID = ?";
    private static final String deleteSql = "DELETE FROM ChatMessages WHERE ID = ?";
    private static final String findByIdSql = "SELECT * FROM ChatMessages WHERE ID = ?";
    private static final String findBySenderSql = "SELECT * FROM ChatMessages WHERE SenderUsername = ? ORDER BY Timestamp DESC";
    private static final String findUnreadSql = "SELECT * FROM ChatMessages WHERE IsRead = 0 ORDER BY Timestamp DESC";
    private static final String markAsReadSql = "UPDATE ChatMessages SET IsRead = 1 WHERE ID = ?";
    private static final String markAllAsReadSql = "UPDATE ChatMessages SET IsRead = 1";

    @Override
    public void create(ChatMessage message) {
        XJdbc.exeUpdate(INSERT_SQL,
            message.getSenderUsername(),
            message.getContent(),
            message.getTimestamp(),
            message.isIsRead()
        );
    }

    @Override
    public void update(ChatMessage entity) {
        Object[] values = {
            entity.getSenderUsername(),
            entity.getContent(),
            entity.getTimestamp(),
            entity.isIsRead(),
            entity.getId()
        };
        XJdbc.exeUpdate(updateSql, values);
    }

    @Override
    public void delete(int id) {
        XJdbc.exeUpdate(deleteSql, id);
    }
    
    @Override
    public void deleteAll() {
        XJdbc.exeUpdate(DELETE_ALL_SQL);
    }

    @Override
    public ChatMessage findById(int id) {
        return XQuery.getSingleBean(ChatMessage.class, findByIdSql, id);
    }

    @Override
    public List<ChatMessage> findAll() {
        return XQuery.getBeanList(ChatMessage.class, SELECT_ALL_SQL);
    }

    @Override
    public List<ChatMessage> findBySender(String sender) {
        return XQuery.getBeanList(ChatMessage.class, findBySenderSql, sender);
    }
    
    @Override
    public List<ChatMessage> findUnread() {
        return XQuery.getBeanList(ChatMessage.class, findUnreadSql);
    }
    
    @Override
    public void markAsRead(int id) {
        XJdbc.exeUpdate(markAsReadSql, id);
    }
    
    @Override
    public void markAllAsRead() {
        XJdbc.exeUpdate(markAllAsReadSql);
    }
} 
