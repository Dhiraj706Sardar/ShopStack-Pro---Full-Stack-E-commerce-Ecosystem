package com.ecommerce.service;

import com.ecommerce.dto.OrderDTO;
import java.io.ByteArrayInputStream;

public interface PdfService {
    ByteArrayInputStream generateInvoice(OrderDTO order);
}
